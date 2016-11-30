From: Franck Jullien <franck.jullien@gmail.com>
Date: Wed, 30 Nov 2016 13:42:52 +0100
Subject: [OpenRISC] [PATCH v2 2/4] gdb: Add OpenRISC or1k and or1knd
	target support (fwd)
In-Reply-To: <b73227fd-e2a6-15d7-c39d-e89d48480b09@embecosm.com>
References: <alpine.LFD.2.20.1611292334190.29569@lianli.shorne-pla.net>
 <b73227fd-e2a6-15d7-c39d-e89d48480b09@embecosm.com>
Message-ID: <CAJfOKBzqQoLctwYpCANNswWF-HD1+Yt0gB_Ho3fzGYKdLmdn0g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

2016-11-29 16:17 GMT+01:00 Jeremy Bennett <jeremy.bennett@embecosm.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 29/11/16 14:53, Stafford Horne wrote:
>>
>> Hi Jeremy,
>>
>> You have probably seen the below. I am wondering if you have any
>> concerns with some of the suggestions. Specifically:
>>
>> * Removing copyright Embecosm Limited and changing to Contributed
>> by Embecosm Limited.
>
> Hi Stafford,
>
> This is no problem. We have corporate FSF approvals in place. Just
> change it to contributed by Jeremy Bennett <jeremy.bennett@embecosm.com>
>
>> * Franck doesn't have copyright assignment, he mentioned you might
>> push the code on his behalf. Since I am pushing the code now what
>> do you think?
>
> Franck needs to send me an email stating that a) he wishes to assign
> his copyright to Embecosm Limited on condition we immediately assign
> it to the FSF and b) he has the authority to make such an assignment
> of copyright. I'll reply accepting the copyright assignment under
> these terms. That gives a legally valid audit trail, since Franck's
> work is owned by us and we have the right to contribute code.
>
> At that point Embecosm can accept the code from Franck and immediately
> assign it to FSF. It probably is safest to use "contributed by Franck
> Julien <email addr> on behalf of Embecosm Limited", but check Franck
> is happy with that. Otherwise someone may quibble about him not being
> on the list.
>
>> The freedback in general is great I think. I have started to clean
>> up several things. But it will take time.
>
> You should think about getting your own FSF approval in place, so you
> can do the final submission.
>
> I'm a bit surprised about the code formatting being wrong, unless it
> is a complaint about commenting. It would be worth checking that this
> is all Yao Qi is concerned about.
>
> My work was used for a tutorial application note, and had detailed
> Doxygen style formatting surrounded by comment lines
> /*---------------------*/. You'll need to strip these down to GNU format.
>
> This is a pain in the neck, because it means the comments will have to
> be moved into and maintained in the tutorial, which has been available
> for years on the GDB wiki. However the fight over inline documentation
> has been going on for years (the GPL and GFDL are not compatible), and
> this submission is not the place for that fight.
>
> You may find the indent tool on Linux useful in auto formatting to GNU
> style.
>
> I'll ask Andrew Burgess to keep an eye out for your postings to review
> them.
>
> Best wishes,
>
>
> Jeremy
>

Hi Jeremy,

I have no objection regarding your proposal.
I'll write an email with the points you mentioned.

Franck.

