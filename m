From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Thu, 31 Aug 2017 21:56:46 +0200
Subject: [OpenRISC] [PATCH v4 0/5] sim port for OpenRISC
In-Reply-To: <20170823062847.GB2587@lianli.shorne-pla.net>
References: <cover.1496066478.git.shorne@gmail.com>
 <20170613101549.GG6190@lianli.shorne-pla.net>
 <20170810132212.GC3031@lianli.shorne-pla.net>
 <20170823062847.GB2587@lianli.shorne-pla.net>
Message-ID: <c233c8b2bda3a47b4ca169571300df95@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-08-23 08:28, Stafford Horne wrote:
> Hello Global Maintainers,
> 
> Its been about a week since I sent the last ping Mike.  It looks like 
> he
> hasnt been active on the list since April.  This is my patch series for 
> the
> OpenRISC sim implementation needed to test and verify gdb.  If possible 
> I
> would like to have it reviewed so I commit this and gdb to upstream.
> 
> At the moment it appears Mike may not be about to continue with the 
> review.
> 
> If someone knows more details please let us know.
> 
> -Stafford

Hi Stafford,

I'll start getting familiar with the patch series and the previous 
versions.  However, it seems like patch 4/5, "sim: or1k: Add generated 
files.", didn't go through.  I don't see it in the archive either:

   https://sourceware.org/ml/gdb-patches/2017-05/threads.html#00594

Is it possible that it was too big and bounced?  If so, is it possible 
to split it?  If not, we'll need to find some other way, maybe you can 
compress it and send it as an attachment?

Simon
