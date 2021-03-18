From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Thu, 18 Mar 2021 00:40:18 +0000
Subject: [OpenRISC] [PATCH v2] mm: Move mem_init_print_info() into
 mm_init()
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Message-ID: <ea5a9027-b0a6-e06d-b3ac-00b8ac43883e@synopsys.com>
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
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
