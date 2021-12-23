From: Stafford Horne <shorne@gmail.com>
Date: Thu, 23 Dec 2021 16:15:42 +0900
Subject: [OpenRISC] [PATCH v3 12/13] build-many-glibcs.py: add OpenRISC
 support
In-Reply-To: <8c8ce20c-eea9-10d5-fef6-08543364fb0d@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-13-shorne@gmail.com>
 <8c8ce20c-eea9-10d5-fef6-08543364fb0d@linaro.org>
Message-ID: <YcQiHuKPNZqgh1Rn@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Dec 22, 2021 at 06:04:07PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> > ---
> >  scripts/build-many-glibcs.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
> > index 6ae2172956..47b2cabc9c 100755
> > --- a/scripts/build-many-glibcs.py
> > +++ b/scripts/build-many-glibcs.py
> > @@ -334,6 +334,10 @@ class Context(object):
> >                                   'ccopts': '-mabi=64'}])
> >          self.add_config(arch='nios2',
> >                          os_name='linux-gnu')
> > +        self.add_config(arch='or1k',
> > +                        os_name='linux-gnu',
> > +                        variant='soft',
> > +                        gcc_cfg=['--with-multilib-list=mcmov'])
> 
> Why is this option required?

The default is to build with multilib-list mcmov,msoft-mul,msoft-div.  Which
would generate 3 toolchains.
To make the build faster I reduced it to the mcmov (support conditional move
instructions).

I could change to run with --disable-multilib, but enabling cmov is usually
always wanted.

> >          self.add_config(arch='powerpc',
> >                          os_name='linux-gnu',
> >                          gcc_cfg=['--disable-multilib', '--enable-secureplt'],
> > @@ -1270,6 +1274,7 @@ def install_linux_headers(policy, cmdlist):
> >                  'microblaze': 'microblaze',
> >                  'mips': 'mips',
> >                  'nios2': 'nios2',
> > +                'or1k': 'openrisc',
> >                  'powerpc': 'powerpc',
> >                  's390': 's390',
> >                  'riscv32': 'riscv',
