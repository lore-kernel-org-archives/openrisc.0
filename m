From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Date: Thu, 12 Jan 2017 08:35:11 +0100
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <1484173670.2619.28.camel@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064803.GB26893@kroah.com>
 <1484158589.2619.14.camel@sandisk.com>
 <20170111203100.GB17895@kroah.com>
 <1484173670.2619.28.camel@sandisk.com>
Message-ID: <20170112073511.GA23347@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jan 11, 2017 at 10:28:05PM +0000, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 21:31 +0100, gregkh at linuxfoundation.org wrote:
> > That's a big sign that your patch series needs work.  Break it up into
> > smaller pieces, it should be possible, which will make merges easier
> > (well, different in a way.)
> 
> Hello Greg,
> 
> Can you have a look at the attached patches? These three patches are a
> splitup of the single patch at the start of this e-mail thread.

Please send them in the proper format (i.e. one patch per email), and I
will be glad to review them.  Otherwise it's really hard to do so, would
you want to review attachments?

thanks,

greg k-h
