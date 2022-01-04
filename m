From: Stafford Horne <shorne@gmail.com>
Date: Tue, 4 Jan 2022 10:43:24 +0900
Subject: [OpenRISC] [PATCH v4 12/13] build-many-glibcs.py: add OpenRISC
 support
In-Reply-To: <a853a130-09c9-68a0-0029-74b859a7af35@linaro.org>
References: <20211229044251.2203653-1-shorne@gmail.com>
 <20211229044251.2203653-13-shorne@gmail.com>
 <a853a130-09c9-68a0-0029-74b859a7af35@linaro.org>
Message-ID: <YdOmPB8dSrXfE2rl@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 03, 2022 at 03:26:01PM -0300, Adhemerval Zanella wrote:
> 
> LGTM, thanks.
> 
> Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

Thank you.

> On 29/12/2021 01:42, Stafford Horne via Libc-alpha wrote:
> > ---
> >  scripts/build-many-glibcs.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
> > index b83bc159fd..ad6e5913e4 100755
> > --- a/scripts/build-many-glibcs.py
> > +++ b/scripts/build-many-glibcs.py
> > @@ -335,6 +335,10 @@ class Context(object):
> >                                   'ccopts': '-mabi=64'}])
> >          self.add_config(arch='nios2',
> >                          os_name='linux-gnu')
> > +        self.add_config(arch='or1k',
> > +                        os_name='linux-gnu',
> > +                        variant='soft',
> > +                        gcc_cfg=['--with-multilib-list=mcmov'])
> >          self.add_config(arch='powerpc',
> >                          os_name='linux-gnu',
> >                          gcc_cfg=['--disable-multilib', '--enable-secureplt'],
> > @@ -1271,6 +1275,7 @@ def install_linux_headers(policy, cmdlist):
> >                  'microblaze': 'microblaze',
> >                  'mips': 'mips',
> >                  'nios2': 'nios2',
> > +                'or1k': 'openrisc',
> >                  'powerpc': 'powerpc',
> >                  's390': 's390',
> >                  'riscv32': 'riscv',
