From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Thu, 16 Dec 2021 07:30:16 -0300
Subject: [OpenRISC] [PATCH v3 03/13] or1k: ABI Implementation
In-Reply-To: <CAAfxs769tWjv-T=vCBpDPn9BB5KCZshzWoCfcejhd47-wZKHcA@mail.gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-4-shorne@gmail.com>
 <a0644ab7-85a5-e22d-607e-4e6761d87610@linaro.org>
 <alpine.DEB.2.22.394.2112142242120.1558178@digraph.polyomino.org.uk>
 <86e61afa-ab95-62e1-10a7-3de71db8deb8@linaro.org>
 <CAAfxs769tWjv-T=vCBpDPn9BB5KCZshzWoCfcejhd47-wZKHcA@mail.gmail.com>
Message-ID: <8bd97df9-e629-feaf-5028-e20f61fd4001@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



On 15/12/2021 20:33, Stafford Horne wrote:
> 
> 
> On Wed, Dec 15, 2021, 10:15 AM Adhemerval Zanella <adhemerval.zanella at linaro.org <mailto:adhemerval.zanella@linaro.org>> wrote:
> 
> 
> 
>     On 14/12/2021 19:43, Joseph Myers wrote:
>     > On Tue, 14 Dec 2021, Adhemerval Zanella via Libc-alpha wrote:
>     >
>     >> +if test "x$profile" != xno; then
>     >> +  if test "x$with_profile" == xno; then
>     >> +    AC_MSG_ERROR([ABI does not support profiling])
>     >
>     > Using == in test is a bashism.
>     >
>     > I'd expect such a change to require the build-many-glibcs.py configuration
>     > for OpenRISC to use --disable-profile.
>     >
> 
>     I ended up mixing up things and what or1k does not support is LD_PROFILE
>     instead of --enable-profile.  In this case I am not sure if it would
>     be better to just not enable it (by ignoring the LD_PROFILE handling
>     in rtld.c or dl-support.c) and emitting a warning or by just dumping
>     and error at process initialization.
> 
> 
> I checked, new ports like csky and arc also do not seem to support LD_PROFILE.  They choose not to leave a placeholder block in dl-machine.h like I did in or1k.
> 
> I could remove the comment, or replace it with an abort, but I prefer to keep it as it makes it clear where to add the dynamic linker profile hook.

I think we should remove the comments, the code might ended up being not updated.

LD_PROFILE seems to be not a really used feature, I will try to clean this up
by adding an internal option that if the port that does not support we,
rtld at least disable all the required code and not start the profile
process (like preparing the file, etc).

