From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 14 Mar 2017 15:55:12 +0000
Subject: [OpenRISC] [PATCH v3 02/25] openrisc: add cache way information
	to cpuinfo
In-Reply-To: <20170314140940.GD2418@lianli.shorne-pla.net>
References: <cover.1487702890.git.shorne@gmail.com>
 <3e06a16339303016b2c57b350a15afeaa7ba7813.1487702890.git.shorne@gmail.com>
 <CAPKp9uadcs_N82DNbhT+FoizVDBA6xCxee9fGGkER3_3+q9rvA@mail.gmail.com>
 <20170314131119.GA10854@chokladfabriken.org>
 <12dd3b5a-08fc-b397-b298-490f72610a5f@arm.com>
 <20170314140940.GD2418@lianli.shorne-pla.net>
Message-ID: <0985732a-e723-9f40-7b1d-663c9bc815a3@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 14/03/17 14:09, Stafford Horne wrote:
> On Tue, Mar 14, 2017 at 01:45:24PM +0000, Sudeep Holla wrote:
>>
>>
>> On 14/03/17 13:11, Stefan Kristiansson wrote:
>>> On Tue, Mar 14, 2017 at 12:08:33PM +0000, Sudeep Holla wrote:
>>>> On Tue, Feb 21, 2017 at 7:11 PM, Stafford Horne <shorne@gmail.com> wrote:
>>>>> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>>>>>
>>>>> Motivation for this is to be able to print the way information
>>>>> properly in print_cpuinfo(), instead of hardcoding it to one.
>>>>>
>>>>
>>>> Any particular reason not to use generic cacheinfo sysfs infrastructure ?
>>>>
>>>
>>> No reason as far as I can see, the creation of this patch predates the
>>> generic cacheinfo sysfs infrastructure.
>>>
>>> The patch itself doesn't add cache information to cpuinfo though,
>>> only corrects a bug in the information that is already there.
>>>
>>> We should look into exposing the info in the generic cache info sysfs
>>> and potentially removing the information from cpuinfo.
>>>
>>
>> Ah OK, sorry I mistook it as a new addition rather than bug fox.
> 
> Hello,
> 
> The comment is appreciated I didnt know about the generic cacheinfo
> intrstructure to be honest.  The simplifications it brings look good, I
> will put this on my todo list.
> 

Thanks.

> If you want to have a go at patching it in for openrisc it would be
> appreciated. :)
> 

Sure I can try if I get time before someone else does that ;)

-- 
Regards,
Sudeep
