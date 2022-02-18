From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 18 Feb 2022 15:45:56 +0000
Subject: [OpenRISC] [PATCH v2 05/18] x86: remove __range_not_ok()
In-Reply-To: <20220218062851.GC22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-6-arnd@kernel.org> <20220218062851.GC22576@lst.de>
Message-ID: <905678e9e05d40b9a4e13e7b1a34cb68@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig
> Sent: 18 February 2022 06:29
...
> 
> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 15b058eefc4e..ee117fcf46ed 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
> >  {
> >  	int ret;
> >
> > -	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
> > +	if (!__access_ok(fp, sizeof(*frame)))
> >  		return 0;
> 
> Just switch the __get_user calls below to get_user instead.

Is this worth doing at all?
How much userspace code is actually compiled with stack frames?

Won't work well for a 32bit process on a 64bit kernel either.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

