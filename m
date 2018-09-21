From: Stafford Horne <shorne@gmail.com>
Date: Fri, 21 Sep 2018 14:40:45 +0200
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <CAF9ehCVy-d4Sv_LAJ1nx140KBH5vUrvyUJLUrRUjW4Upaxk8SA@mail.gmail.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
 <20180918095234.GP4594@lianli.shorne-pla.net>
 <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
 <CAF9ehCVy-d4Sv_LAJ1nx140KBH5vUrvyUJLUrRUjW4Upaxk8SA@mail.gmail.com>
Message-ID: <CAAfxs76t9D81KW++Kv4Y_qR-Uw_DtCxQEUafwmS8cgq89U9gCA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Joel,


On Tue, Sep 18, 2018 at 2:07 PM, Joel Sherrill <joel@rtems.org> wrote:

>
>
> On Tue, Sep 18, 2018, 6:56 AM Nick Clifton <nickc@redhat.com> wrote:
>
>>
>> > As Richard mentioned we don't handle this.
>> >
>> > We have cases like this right now as well, i.e. binaries generated with
>> `l.mul`
>> > or `l.div` instructions will link fine into an executable that assume
>> those
>> > instrunctions should be emulated.  That doesn't throw an error and I
>> don't think
>> > it has been a problem.
>>
>> OK, well it is your target, so if you are OK with this then so be it.
>> I would recommend however thinking about a solution for the future,
>> should the
>> openRISC architecture gain more variants.  My suggestion would be to make
>> use
>> of ELF notes, as has been done with other ports.
>>
>
> Is there a way to avoid these instructions with GCC? As a general rule,
> for RTEMS we assume the code is properly generated for the target CPU and
> don't emulate missing instructions.
>
> Also for these cases, is there a flag implicitly set by GCC based on CPU
> specific flags to let assembly code.know not to use them.
>
> And are there mulilibs which do and do not use them?
>

To answer all, yes.  There were some recent openrisc mailing list
discussions on this. I have decided to add a new multilib flag -mclass1
-mclass2 (default is mclass1 instructions only) to  stop gcc from using any
class2 instructions.


> In the deeply embedded space, we assume the tools and user can generate
> code which doesn't need emulation traps. There is some responsibility on
> the toolchain to.make it possible.
>

Yes, We did think about this when we were writing the new port, but we are
only just implementing it now.  Check the GCC docs in the next patch
version I submit.

-Stafford
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180921/c56779cd/attachment.html>
