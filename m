From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Apr 2017 01:14:19 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 7/7] target/openrisc: Implement
 full vmstate serialization
In-Reply-To: <fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
Message-ID: <2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> Previously serialization did not persist the tlb, timer, pic and other
> key state items.  This meant snapshotting and restoring a running os
> would crash. After adding these I am able to take snapshots of a
> running linux os and restore at a later time.
>
> I am currently not trying to maintain capatibility with older versions
> as I do not believe this really worked before or anyone used it.

That's fine, but you still have to bump the version numbers.


r~

