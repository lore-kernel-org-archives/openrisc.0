From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 26 Apr 2018 17:39:20 +0800
Subject: [OpenRISC] [PATCH 13/22] nds32: use generic dma_noncoherent_ops
In-Reply-To: <20180426082429.GA15580@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-14-hch@lst.de>
 <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
 <20180424191640.GA32495@lst.de>
 <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com>
 <20180425064055.GA11460@lst.de>
 <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com>
 <20180426064239.GA13895@lst.de>
 <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
 <20180426082429.GA15580@lst.de>
Message-ID: <CAEbi=3dnduyq3k8hkoLu180EtwCQ5-Hz0jc1iviv70WXp7yUJg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

2018-04-26 16:24 GMT+08:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Apr 26, 2018 at 04:06:34PM +0800, Greentime Hu wrote:
>> It works!!!
>
> Thanks!
>
> Can you retest the updated tree here with all the fixes and give me
> your Tested-by: for the generic and nds32 patches?
>
> git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent

Sorry Christoph. I found the previous mail I said it works was wrong
because I used a wrong vmlinux.
It still failed. >,<
