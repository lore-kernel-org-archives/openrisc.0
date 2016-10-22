From: Stafford Horne <shorne@gmail.com>
Date: Sat, 22 Oct 2016 17:04:12 +0900
Subject: [OpenRISC] Openrisc Specification
In-Reply-To: <alpine.LFD.2.20.1610070209350.3778@lianli.shorne-pla.net>
References: <alpine.LFD.2.20.1610040755170.3778@lianli.shorne-pla.net>
 <aa80189d-f993-5693-8b31-0e02e552df4b@wallentowitz.de>
 <alpine.LFD.2.20.1610070209350.3778@lianli.shorne-pla.net>
Message-ID: <CAAfxs76LACRaf8cf12x1cKiUS3NQxxb1VW_MedHBMBaZiuPJ=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Oct 7, 2016 at 2:11 AM, Stafford Horne <shorne@gmail.com> wrote:
>
>
> On Tue, 4 Oct 2016, Stefan Wallentowitz wrote:
>
>> On 04.10.2016 02:24, Stafford Horne wrote:
>>>
>>> Hi All,
>>>
>>> As many problably know opencores was offline for some time over the past
>>> week. The openrisc specification process currently depends on being able
>>> to post specifiations on the wiki here:
>>>  http://opencores.org/or1k/Architecture_Specification
>>>
>>> Would anyone be apposed to moving the specification process to
>>> http://openrisc.io?  There is already a page for specification setup
>>> there.
>>>
>>> If we would agree I could do the work to
>>>  1. Add old specification history to the openrisc.io page
>>>  2. Describe the change submission process
>>>    - Create a page change pull requests
>>>    - Send mail to this mailing list for discssion
>>>    - Periodically discuss the final cut of changes
>>>    - Update the docs and post the changes back to the Specification page
>>>      and download page
>>
>>
>> Hi Stafford,
>>
>> thanks a lot for picking that up. I once had the plan to get the new
>> revision done by ORCONF 2015, but the old story of time and focus..
>>
>> I like the process. I originally thought about moving the specification
>> entirely to Github issues, but having it integrated is a great idea.
>>
>> One thing I still have in mind is how to resolve conflicts if any. Will
>> we have to do voting then?
>>
> Hi Stefan,
>
> I thin confilcts can be discussed on the mailing list as well. But maybe a
> voting system would be more applicable. Did we ever have conflicts in the
> past that we can learn from?
>

Hi All,

I created a pull request for moving this process to openrisc.io.   We
can discussed on github [1], but if anyone wants to see a sample of
what it looks like you can see directly on my branch page [2] (sorry
links and theme are broken due to page using absolute paths).

I also migrated all the pending proposals and revision details from the wiki.

The idea is that when people want to make a proposal they would create
a new proposal page on openrisc.io and we can discuss that.  Once
enough proposals have been accepted a new revision will be created
updating the pdf documents and moving the proposals from draft status
into the revision.

I am not sure if this is too complicated, but it seems pretty easy and
structure from my perspective.

[1] https://github.com/openrisc/openrisc.github.io/pulls
[2] https://stffrdhrn.github.io/openrisc.github.io/architecture

