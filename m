From: Calvin Zhang <calvinzhang.cool@gmail.com>
Date: Sun, 21 Nov 2021 17:01:20 +0800
Subject: [OpenRISC] [PATCH 0/2] of: remove reserved regions count
 restriction
In-Reply-To: <YZnqo3oA7srQik4N@kernel.org>
References: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
 <YZnqo3oA7srQik4N@kernel.org>
Message-ID: <YZoK4IiBOTPduEyN@debian>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Nov 21, 2021 at 08:43:47AM +0200, Mike Rapoport wrote:
>On Fri, Nov 19, 2021 at 03:58:17PM +0800, Calvin Zhang wrote:
>> The count of reserved regions in /reserved-memory was limited because
>> the struct reserved_mem array was defined statically. This series sorts
>> out reserved memory code and allocates that array from early allocator.
>> 
>> Note: reserved region with fixed location must be reserved before any
>> memory allocation. While struct reserved_mem array should be allocated
>> after allocator is activated. We make early_init_fdt_scan_reserved_mem()
>> do reservation only and add another call to initialize reserved memory.
>> So arch code have to change for it.
>
>I think much simpler would be to use the same constant for sizing
>memblock.reserved and reserved_mem arrays.
>
>If there is too much reserved regions in the device tree, reserving them in
>memblock will fail anyway because memblock also starts with static array
>for memblock.reserved, so doing one pass with memblock_reserve() and
>another to set up reserved_mem wouldn't help anyway.

Yes. This happens only if there are two many fixed reserved regions.
memblock.reserved can be resized after paging.

I also find another problem. Initializing dynamic reservation after
paging would fail to mark it no-map because no-map flag works when doing
direct mapping. This seems to be a circular dependency.

Thank You,
Calvin
