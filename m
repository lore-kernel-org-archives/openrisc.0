From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Tue, 05 Sep 2017 20:52:53 +0200
Subject: [OpenRISC] [PATCH v4 3/5] sim: or1k: add or1k target to sim
In-Reply-To: <20170904214854.GN2609@lianli.shorne-pla.net>
References: <cover.1496066478.git.shorne@gmail.com>
 <aaf9bb46e9b3a59d1fff197c08fa25c7e0bd3b16.1496066478.git.shorne@gmail.com>
 <617acff0490f4ae9ffcf961fb55b2ef1@polymtl.ca>
 <20170904214854.GN2609@lianli.shorne-pla.net>
Message-ID: <1735cd0e32315069945129777d92710f@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-09-04 23:48, Stafford Horne wrote:
> This is here to configure the UPR[UP] (UPR is present flag) to 1, even 
> in
> case we didnt set it above when we do:
> 
>   SET_H_SYS_UPR (or1k_upr);
> 
> The call to SET_H_SYS_UPR() sets all of the flags in the UPR as sent in
> from the user arguments.  If they didn't set UPR[UP] we make sure it 
> gets
> set.

Oh ok for some reason I though that CHECK_SPR_FIELD was throwing an 
error when a check failed, but actually it just prints a warning.  
That's why I thought that the UP bit would necessarily already be set at 
this point.

Sorry about that.

Simon
