From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Tue, 15 Dec 2020 22:51:57 +0100
Subject: [OpenRISC] [RFC PATCH] treewide: remove bzip2 compression
 support
In-Reply-To: <20201215190315.8681-1-alex_y_xu@yahoo.ca>
References: <20201215190315.8681-1-alex_y_xu.ref@yahoo.ca>
 <20201215190315.8681-1-alex_y_xu@yahoo.ca>
Message-ID: <20201215215157.GJ6564@kitsune.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

On Tue, Dec 15, 2020 at 02:03:15PM -0500, Alex Xu (Hello71) wrote:
> bzip2 is either slower or larger than every other supported algorithm,
> according to benchmarks at [0]. It is far slower to decompress than any
> other algorithm, and still larger than lzma, xz, and zstd.
> 
> [0] https://lore.kernel.org/lkml/1588791882.08g1378g67.none at localhost/

Sounds cool. I wonder how many people will complain that their
distribution migrated to bzip2 but got stuck there and now new kernels
won't work on there with some odd tool or another :p

> @@ -212,11 +209,6 @@ choice
>  	  Compression speed is only relevant when building a kernel.
>  	  Decompression speed is relevant at each boot.
>  
> -	  If you have any problems with bzip2 or lzma compressed
> -	  kernels, mail me (Alain Knaff) <alain@knaff.lu>. (An older
> -	  version of this functionality (bzip2 only), for 2.4, was
> -	  supplied by Christian Ludwig)
> -
Shouldn't the LZMA part be preserved here?

Thanks

Michal
