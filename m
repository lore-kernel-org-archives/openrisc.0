From: Dave Hansen <dave.hansen@intel.com>
Date: Wed, 17 Mar 2021 11:48:50 -0700
Subject: [OpenRISC] [PATCH v2] mm: Move mem_init_print_info() into
 mm_init()
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Message-ID: <2a7d6e39-b293-7422-87b0-741f1ab0c22c@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 3/16/21 6:52 PM, Kefeng Wang wrote:
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

It's not a big deal but you might want to say something like:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86 bits

Just to make it clear that I didn't look at the alpha bits at all. :)
