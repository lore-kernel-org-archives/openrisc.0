From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 15 Feb 2022 11:25:44 +0100
Subject: [OpenRISC] [PATCH 03/14] nds32: fix access_ok() checks in
 get/put_user
In-Reply-To: <CAK8P3a1XkWNQcFEhJQ0+qWzih1YRQDS_N8xiosN7FHn3yoTJpQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org>
 <YgqK1ihlJvRFHJ9h@infradead.org>
 <CAK8P3a1XkWNQcFEhJQ0+qWzih1YRQDS_N8xiosN7FHn3yoTJpQ@mail.gmail.com>
Message-ID: <Ygt/qMduFQIjWqfU@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 10:18:15AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 14, 2022 at 6:01 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The get_user()/put_user() functions are meant to check for
> > > access_ok(), while the __get_user()/__put_user() functions
> > > don't.
> > >
> > > This broke in 4.19 for nds32, when it gained an extraneous
> > > check in __get_user(), but lost the check it needs in
> > > __put_user().
> >
> > Can we follow the lead of MIPS (which this was originally copied
> > from I think) and kill the pointless __get/put_user_check wrapper
> > that just obsfucate the code?
> 
> I had another look, but I think that would be a bigger change than
> I want to have in a fix for stable backports, as nds32 also uses
> the _check versions in __{get,put}_user_error.

Don't worry about stable backports first, get it correct and merged and
then worry about them if you really have to.

If someone cares about nds32 for stable kernels, they can do the
backport work :)

thanks,

greg k-h
