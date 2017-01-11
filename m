From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Date: Wed, 11 Jan 2017 22:28:05 +0000
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <20170111203100.GB17895@kroah.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064803.GB26893@kroah.com> <1484158589.2619.14.camel@sandisk.com>
 <20170111203100.GB17895@kroah.com>
Message-ID: <1484173670.2619.28.camel@sandisk.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 2017-01-11 at 21:31 +0100, gregkh at linuxfoundation.org wrote:
> That's a big sign that your patch series needs work.  Break it up into
> smaller pieces, it should be possible, which will make merges easier
> (well, different in a way.)

Hello Greg,

Can you have a look at the attached patches? These three patches are a
splitup of the single patch at the start of this e-mail thread.

Thanks,

Bart.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-treewide-Move-dma_ops-from-struct-dev_archdata-into-.patch
Type: text/x-patch
Size: 22418 bytes
Desc: 0001-treewide-Move-dma_ops-from-struct-dev_archdata-into-.patch
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170111/bdb07969/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-treewide-Consolidate-set_dma_ops-implementations.patch
Type: text/x-patch
Size: 2885 bytes
Desc: 0002-treewide-Consolidate-set_dma_ops-implementations.patch
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170111/bdb07969/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-treewide-Consolidate-get_dma_ops-implementations.patch
Type: text/x-patch
Size: 19530 bytes
Desc: 0003-treewide-Consolidate-get_dma_ops-implementations.patch
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170111/bdb07969/attachment-0005.bin>
