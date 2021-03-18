From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Thu, 18 Mar 2021 09:01:54 +0800
Subject: [OpenRISC] [PATCH v2] mm: Move mem_init_print_info() into
 mm_init()
In-Reply-To: <2a7d6e39-b293-7422-87b0-741f1ab0c22c@intel.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
 <2a7d6e39-b293-7422-87b0-741f1ab0c22c@intel.com>
Message-ID: <190f5356-f947-d474-a9fe-bc8e622a426e@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On 2021/3/18 2:48, Dave Hansen wrote:
> On 3/16/21 6:52 PM, Kefeng Wang wrote:
>> mem_init_print_info() is called in mem_init() on each architecture,
>> and pass NULL argument, so using void argument and move it into mm_init().
>>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> It's not a big deal but you might want to say something like:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86 bits
>
> Just to make it clear that I didn't look at the alpha bits at all. :)
Get it, will be careful, thanks.
> .
>
