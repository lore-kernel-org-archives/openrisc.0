From: Jeff Law <law@redhat.com>
Date: Wed, 31 Oct 2018 08:39:14 -0600
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181030223553.GD2843@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <20181028214723.GD1761@lianli.shorne-pla.net>
 <20181028225447.GK5766@gate.crashing.org>
 <20181030124918.GC2843@lianli.shorne-pla.net>
 <20181030154952.GD5994@gate.crashing.org>
 <20181030223553.GD2843@lianli.shorne-pla.net>
Message-ID: <0354c1e4-3482-1536-e7c0-fc23f94dc4f7@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/30/18 4:35 PM, Stafford Horne wrote:
> On Tue, Oct 30, 2018 at 10:49:53AM -0500, Segher Boessenkool wrote:
>> On Tue, Oct 30, 2018 at 09:49:18PM +0900, Stafford Horne wrote:
>>> Hello,
>>>
>>> On Sun, Oct 28, 2018 at 05:54:47PM -0500, Segher Boessenkool wrote:
>>>> Yes, like that.  It also easily can handle the other combos (those with
>>>> STACK_POINTER), and it is easier if you have to switch FRAME_GROWS_DOWNWARD
>>>> ("false" is better on some args, but "true" is required for ssp).
>>>>
>>>> Your code is fine as-is of course.
>>>
>>> Just to be clear, when you say 'as-is' did you mean the original v3 patch?  Or
>>> are you referring to followup patch I posted with the some_offset (from) -
>>> some_offset (to) logic.
>>
>> Either.  Both.  I meant the orig big patch, v3 if that's what it was.
> 
> Alright, thanks, I just didnt want to misunderstand.
Also note that it's my understanding the issues I raised during my
review have been dealt with as have Joseph's.  My inclination would be
to accept the port when Stafford & rth think it's ready.


Jeff
