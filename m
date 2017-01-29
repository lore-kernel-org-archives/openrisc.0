From: Stafford Horne <shorne@gmail.com>
Date: Sun, 29 Jan 2017 22:05:08 +0900
Subject: [OpenRISC] [linux-next:master 3724/5750]
 drivers/block/drbd/drbd_req.c:955:3: error: implicit declaration of
 function 'test_and_change_bit'
In-Reply-To: <201701290951.idaFnKE3%fengguang.wu@intel.com>
References: <201701290951.idaFnKE3%fengguang.wu@intel.com>
Message-ID: <20170129130508.GA32144@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Jan 29, 2017 at 09:03:54AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   f37208bc3c9c2f811460ef264909dfbc7f605a60
> commit: 116ded1356614cff3facc9010125b5a28718cbf1 [3724/5750] openrisc: add atomic bitops
> config: openrisc-allyesconfig (attached as .config)
> compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 116ded1356614cff3facc9010125b5a28718cbf1
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/block/drbd/drbd_req.c: In function 'remote_due_to_read_balancing':
> >> drivers/block/drbd/drbd_req.c:955:3: error: implicit declaration of function 'test_and_change_bit'
> --
>    net/bluetooth/mgmt.c: In function 'set_external_config':
> >> net/bluetooth/mgmt.c:5591:3: error: implicit declaration of function 'test_and_change_bit'

Hello,

Thanks, it looks like this test_and_change_bit() was missed in the
recent atomic bitops patch. Its not really used much so I guess it
slipped by.

We will get it added.

-Stafford

> vim +/test_and_change_bit +955 drivers/block/drbd/drbd_req.c
> 
> 380207d0 Philipp Reisner     2011-11-11  939  	switch (rbm) {
> 380207d0 Philipp Reisner     2011-11-11  940  	case RB_CONGESTED_REMOTE:
> b30ab791 Andreas Gruenbacher 2011-07-03  941  		bdi = &device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
> 380207d0 Philipp Reisner     2011-11-11  942  		return bdi_read_congested(bdi);
> 380207d0 Philipp Reisner     2011-11-11  943  	case RB_LEAST_PENDING:
> b30ab791 Andreas Gruenbacher 2011-07-03  944  		return atomic_read(&device->local_cnt) >
> b30ab791 Andreas Gruenbacher 2011-07-03  945  			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
> d60de03a Philipp Reisner     2011-11-17  946  	case RB_32K_STRIPING:  /* stripe_shift = 15 */
> d60de03a Philipp Reisner     2011-11-17  947  	case RB_64K_STRIPING:
> d60de03a Philipp Reisner     2011-11-17  948  	case RB_128K_STRIPING:
> d60de03a Philipp Reisner     2011-11-17  949  	case RB_256K_STRIPING:
> d60de03a Philipp Reisner     2011-11-17  950  	case RB_512K_STRIPING:
> d60de03a Philipp Reisner     2011-11-17  951  	case RB_1M_STRIPING:   /* stripe_shift = 20 */
> d60de03a Philipp Reisner     2011-11-17  952  		stripe_shift = (rbm - RB_32K_STRIPING + 15);
> d60de03a Philipp Reisner     2011-11-17  953  		return (sector >> (stripe_shift - 9)) & 1;
> 380207d0 Philipp Reisner     2011-11-11  954  	case RB_ROUND_ROBIN:
> b30ab791 Andreas Gruenbacher 2011-07-03 @955  		return test_and_change_bit(READ_BALANCE_RR, &device->flags);
> 380207d0 Philipp Reisner     2011-11-11  956  	case RB_PREFER_REMOTE:
> 380207d0 Philipp Reisner     2011-11-11  957  		return true;
> 380207d0 Philipp Reisner     2011-11-11  958  	case RB_PREFER_LOCAL:
> 380207d0 Philipp Reisner     2011-11-11  959  	default:
> 380207d0 Philipp Reisner     2011-11-11  960  		return false;
> 380207d0 Philipp Reisner     2011-11-11  961  	}
> 380207d0 Philipp Reisner     2011-11-11  962  }
> 380207d0 Philipp Reisner     2011-11-11  963  
> 
> :::::: The code at line 955 was first introduced by commit
> :::::: b30ab7913b0a7b1d3b1091c8cb3abb1a9f1e0824 drbd: Rename "mdev" to "device"
> 
> :::::: TO: Andreas Gruenbacher <agruen@linbit.com>
> :::::: CC: Philipp Reisner <philipp.reisner@linbit.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


