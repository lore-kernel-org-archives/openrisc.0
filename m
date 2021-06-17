From: Stafford Horne <shorne@gmail.com>
Date: Fri, 18 Jun 2021 08:41:27 +0900
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <6bc67759-18c2-bca5-bdb2-c637e873b8ab@benettiengineering.com>
References: <dbcce22d-b288-2451-4a8d-681f802c6f49@benettiengineering.com>
 <CAAfxs77Y1qOzex=Bkn5c_4Zxt6nzZP2cpG6qJ85eXnrAm18FgA@mail.gmail.com>
 <6bc67759-18c2-bca5-bdb2-c637e873b8ab@benettiengineering.com>
Message-ID: <YMvdpzYqcwNzAeQ/@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, May 25, 2021 at 01:03:37AM +0200, Giulio Benetti wrote:
> On 5/25/21 12:34 AM, Stafford Horne wrote:
> > I'm cc'ing the list so there is a record, and other experts could come
> > in if they like.
> 
> Ah yes, pardon
> 
> > Ok, I'll take a look.
> > 
> > Thanks,  these are always fun for me.
> 
> That's great :-)

So I finally had some time to look at this.  I think I understand the issue, but
not sure of the fix yet.  Let me explain for the record:

1. The error:

 When building openal we get the following:

    /home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
    CMakeFiles/OpenAL.dir/al/source.cpp.o: pc-relative relocation against dynamic
    symbol alSourcePausev
    /home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
    CMakeFiles/OpenAL.dir/al/source.cpp.o: pc-relative relocation against dynamic
    symbol alSourceStopv
    /home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
    CMakeFiles/OpenAL.dir/al/source.cpp.o: pc-relative relocation against dynamic
    symbol alSourceRewindv
    /home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
    CMakeFiles/OpenAL.dir/al/source.cpp.o: pc-relative relocation against dynamic
    symbol alSourcePlayv
    /home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
    final link failed: bad value

2. This is caused by this code in bfd for or1k.


        case R_OR1K_INSN_REL_26:
        case R_OR1K_PCREL_PG21:
        case R_OR1K_LO13:
        case R_OR1K_SLO13:
          /* For a non-shared link, these will reference either the plt
             or a .dynbss copy of the symbol.  */
          if (bfd_link_pic (info) && !SYMBOL_REFERENCES_LOCAL (info, h))
            {
              _bfd_error_handler
                (_("%pB: pc-relative relocation against dynamic symbol %s"),
                 input_bfd, name);
              ret_val = false;
              bfd_set_error (bfd_error_bad_value);
            }
          break;

3. The code being linked is this from `objdump -dr`:

    0000a198 <alSourcePlay>:
	a198:       9c 21 ff f8     l.addi r1,r1,-8
	a19c:       d4 01 18 00     l.sw 0(r1),r3
	a1a0:       e0 81 08 04     l.or r4,r1,r1
	a1a4:       d4 01 48 04     l.sw 4(r1),r9
	a1a8:       04 00 00 00     l.jal a1a8 <alSourcePlay+0x10>
			    a1a8: R_OR1K_INSN_REL_26        alSourcePlayv
	a1ac:       a8 60 00 01     l.ori r3,r0,0x1
	a1b0:       85 21 00 04     l.lwz r9,4(r1)
	a1b4:       44 00 48 00     l.jr r9
	a1b8:       9c 21 00 08     l.addi r1,r1,8

3.a. The cpp for this is:

    AL_API ALvoid AL_APIENTRY alSourcePlay(ALuint source)
    START_API_FUNC
    { alSourcePlayv(1, &source); }
    END_API_FUNC

    AL_API ALvoid AL_APIENTRY alSourcePlayv(ALsizei n, const ALuint *sources)
    START_API_FUNC
    {
	ContextRef context{GetContextRef()};
	if UNLIKELY(!context) return;
    ...

4. The symbols are from `readelf -s`:

   221: 00008ce4   716 FUNC    GLOBAL PROTECTED   24 alSourcePausev
   222: 00008fb0    36 FUNC    GLOBAL PROTECTED   24 alSourcePause
   223: 00008fd4   784 FUNC    GLOBAL PROTECTED   24 alSourceStopv
   224: 000092e4    36 FUNC    GLOBAL PROTECTED   24 alSourceStop
   225: 00009308   720 FUNC    GLOBAL PROTECTED   24 alSourceRewindv
   226: 000095d8    36 FUNC    GLOBAL PROTECTED   24 alSourceRewind


5. Summary

So the issue is that bfd is complaining that because we are doing a PIC link
we should not have any R_OR1K_INSN_REL_26 relocations (local calls) to global
symbols.  Since alSourcePausev / alSourceStopv / alSourcePlayv are global
symbols we get this warning.

The compiler produced a local jump to the global function, BFD is saying it
should be going through the PLT so that runtime linking could be overridden.

I looked at the x86 binary and confirm that x86 also uses a local jump, so it
could be that the or1k BFD check is being too strict.  I will have to read up a
bit more about the rules for this to understand what is the right fix.

I am CCing Richard who added this check and the binutils list to see if there
are any thoughts.

-Stafford

> > Also I forgot to respond about nios2 bugs. I could help if the bug
> > looked the same. But to me it looked different.  So I'll hold off for
> > now.
> 
> Ok, no problem. Thank you for fixing he OpenRisc ones.
> 
> Best regards
> -- 
> Giulio Benetti
> Benetti Engineering sas
> 
> > On Tue, May 25, 2021, 7:10 AM Giulio Benetti
> > <giulio.benetti@benettiengineering.com
> > <mailto:giulio.benetti@benettiengineering.com>> wrote:
> > 
> >     Hi Stafford,
> > 
> >     I think I've found another or1k ld bug. Here is the build failure log:
> >     http://autobuild.buildroot.net/results/ca3/ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf/build-end.log
> >     <http://autobuild.buildroot.net/results/ca3/ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf/build-end.log>
> > 
> >     It complains about:
> >     pc-relative relocation against dynamic symbol
> > 
> >     there is an archive of some files(libcommon.a) compiled in the
> >     beginning
> >     that gets linked with the rest of .o files. Every file is compiled with
> >     -fPIC option so this should allow to link a .o with .a but it throws
> >     that error.
> > 
> >     I only see that error in or1k and alpha. Maybe I'm missing something.
> >     When you have time and if you want, can you help me with that?
> > 
> >     If you want to reproduce it it's the same procedure of previous bugs
> >     but
> >     you need to specify ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf to
> >     br-reproduce-build.
> > 
> >     Thanks in advance
> >     and
> >     Best regards
> >     --     Giulio Benetti
> >     Benetti Engineering sas
> > 
> 
