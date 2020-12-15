From: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Date: Tue, 15 Dec 2020 18:39:17 -0500
Subject: [OpenRISC] [RFC PATCH] treewide: remove bzip2 compression
 support
In-Reply-To: <20201215190315.8681-1-alex_y_xu@yahoo.ca>
References: <20201215190315.8681-1-alex_y_xu.ref@yahoo.ca>
 <20201215190315.8681-1-alex_y_xu@yahoo.ca>
Message-ID: <1608075451.ootu1tx25o.none@localhost>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Excerpts from Alex Xu (Hello71)'s message of December 15, 2020 2:03 pm:
> bzip2 is either slower or larger than every other supported algorithm,
> according to benchmarks at [0]. It is far slower to decompress than any
> other algorithm, and still larger than lzma, xz, and zstd.
> 
> [0] https://lore.kernel.org/lkml/1588791882.08g1378g67.none at localhost/
> 
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Upon further research, I found that bzip2 removal was already 
implemented as part of zstd addition, but were apparently abandoned in 
an effort to get zstd in. I will check those patches and try sending 
those instead. Thanks to all reviewers for comments on this patch.
