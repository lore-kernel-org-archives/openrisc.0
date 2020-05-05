From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Tue, 5 May 2020 17:27:16 +0000
Subject: [OpenRISC] [PATCH v2 17/20] mm: free_area_init: allow defining
 max_zone_pfn in descending order
In-Reply-To: <ca099c3e-c0bc-cd2f-cdb0-852dfc2c10db@roeck-us.net>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
 <20200503174138.GA114085@roeck-us.net> <20200503184300.GA154219@roeck-us.net>
 <20200504153901.GM14260@kernel.org>
 <ca099c3e-c0bc-cd2f-cdb0-852dfc2c10db@roeck-us.net>
Message-ID: <51b468f8-c05b-a019-f473-429622083045@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/5/20 6:18 AM, Guenter Roeck wrote:
> On 5/4/20 8:39 AM, Mike Rapoport wrote:
>> On Sun, May 03, 2020 at 11:43:00AM -0700, Guenter Roeck wrote:
>>> On Sun, May 03, 2020 at 10:41:38AM -0700, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Wed, Apr 29, 2020 at 03:11:23PM +0300, Mike Rapoport wrote:
>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>
>>>>> Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
>>>>> ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
>>>>> sorted in descending order allows using free_area_init() on such
>>>>> architectures.
>>>>>
>>>>> Add top -> down traversal of max_zone_pfn array in free_area_init() and use
>>>>> the latter in ARC node/zone initialization.
>>>>>
>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>> This patch causes my microblazeel qemu boot test in linux-next to fail.
>>>> Reverting it fixes the problem.
>>>>
>>> The same problem is seen with s390 emulations.
>> Yeah, this patch breaks some others as well :(
>>
>> My assumption that max_zone_pfn defines architectural limit for maximal
>> PFN that can belong to a zone was over-optimistic. Several arches
>> actually do that, but others do
>>
>> 	max_zone_pfn[ZONE_DMA] = MAX_DMA_PFN;
>> 	max_zone_pfn[ZONE_NORMAL] = max_pfn;
>>
>> where MAX_DMA_PFN is build-time constrain and max_pfn is run time limit
>> for the current system.
>>
>> So, when max_pfn is lower than MAX_DMA_PFN, the free_init_area() will
>> consider max_zone_pfn as descending and will wrongly calculate zone
>> extents.
>>
>> That said, instead of trying to create a generic way to special case
>> ARC, I suggest to simply use the below patch instead.
>>
> As a reminder, I reported the problem against s390 and microblazeel
> (interestingly enough, microblaze (big endian) works), not against arc.

Understood and my comment was to point to any other problems in future.

Thx,
-Vineet
