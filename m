From: Stafford Horne <shorne@gmail.com>
Date: Sun, 6 Jun 2021 20:11:21 +0900
Subject: [OpenRISC] Comments on your student's post
In-Reply-To: <CADGJwMzLEPAMNzouZ9xS9zNy0HBsZ6ZXeYUeaPzqu43W2tKupA@mail.gmail.com>
References: <CALo8C4vWB2dgF9Q3SV4gPczTe89L41O3SMoyvy9ENyDyCgCSgQ@mail.gmail.com>
 <CAAfxs77VQAGGrH1f9A6P9thnCamyZz_JhBW=4GDTautHPYCWTA@mail.gmail.com>
 <CALo8C4vNaR37O2YJk2QM3BKNvK-qZAS0AZ8mz-kxqZ0_oeNyoA@mail.gmail.com>
 <CAAfxs77MeZQVotRtzyAH-D5jXg6xdDbbefdduPYTt3uBw-Ft6Q@mail.gmail.com>
 <CADGJwMzLEPAMNzouZ9xS9zNy0HBsZ6ZXeYUeaPzqu43W2tKupA@mail.gmail.com>
Message-ID: <CAAfxs76H42EpZ3gdiRt3o1COgerPwP3sXctxHB2X=HornY-0BA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

+cc the list.

This is a great resource for us getting started with OpenRISC formal
verification.

-Stafford

On Sun, Jun 6, 2021, 7:02 PM Harshitha S <harshithasridhar172000@gmail.com>
wrote:

> Hello,
>
> Yeah, it's okay with keeping the OpenRISC list in CC for further
> discussion.
>
> Dan,
> Thanks for the constructive feedback, the points which you have shared
> with me will help me improve the code. Thanks for letting me know that you
> are available on the platforms which you've mentioned for asking questions.
>
> I agree with you about not including memory within a larger design's
> proof. Yes, spending time perfecting the interface can cost a lot of time
> finding the bugs, and formally verifying large aggregated designs can be
> challenging. I had a look at the blog where you have explained to formally
> verify memory-like components by assuming just one arbitrary address and
> using it to verify the transactions. Yes, I feel the same that the proof
> will run a lot faster by not verifying the entire memory, but just a single
> address. Sure, I'll also have a look into your interface property files in
> your GitHub repository. I've noted down the point you have stressed upon
> "initial assumptions". Also, the key thing which you've said is important
> to avoid assuming anything internal to a module and the keyword (restrict)
> which you've recommended to avoid as it can be replaced with a good assume
> statement. I'll try to avoid the Yosys' chparam statement as much as
> possible and use the hierarchy command itself for the parameter adjustments.
>
> Thanks again for all the links provided, I'll definitely go through it. We
> can have a discussion sometime in the future.
>
> On Sun, Jun 6, 2021 at 5:53 AM Stafford Horne <shorne@gmail.com> wrote:
>
>> Hello,
>>
>> This is a reply from Dan regarding your latest post.  Do you mind I cc
>> you and the OpenRISC mail list for further discussion?
>>
>> ---------- Forwarded message ---------
>> From: Zip CPU <zipcpu@gmail.com>
>> Date: Sun, Jun 6, 2021, 9:12 AM
>> Subject: Re: Comments on your student's post
>> To: Stafford Horne <shorne@gmail.com>
>>
>>
>> Stafford,
>> Feel free to CC the list with Harshita's permission. I have nothing to
>> hide in my response.
>>
>> Regarding your comments:
>>
>> 1, When verifying a larger design, do you need to have the memory within
>> the larger design's proof?  I personally don't include the memory in the
>> proof of the ZipCPU's core processor, nor in the proof of the various
>> memory controllers, etc.  The only time all the parts and pieces come
>> together is in the simulation in the end.  Formally verifying aggregated
>> designs can be a real challenge.  Remember, the cost of any formal proof
>> goes up exponentially with its complexity.  A good engineer learns quickly
>> how to manage such.
>>
>> 2. Yes, a well written interface description is as good as gold in this
>> environment.
>>
>> Beware, there was a customer we once dealt with that put a *lot* of
>> energy into building the "perfect" interface for a particular bus.  (I
>> think it was Avalon.)  The "perfect" interface then cost them a lot of time
>> and dollars finding bugs in "working" items, bugs that would never be
>> encountered in real life.  This effort then soured their further interest
>> in formal methods.  Bottom line: don't lose your perspective on things.  ;)
>>
>> 3-7: no comment necessary.
>>
>> I am also on Gitter under the name ZipCPU.  You can find me on the
>> #librecores/ fusesoc, librecores, or Lobby channels.  Since I can't tell
>> which user name is Harshita's, feel free to have her introduce herself to
>> me.
>>
>> Dan
>>
>> On Sat, Jun 5, 2021 at 4:58 PM Stafford Horne <shorne@gmail.com> wrote:
>>
>>> Thanks Dan,
>>>
>>> This might be good to have in public as its great info, do you mind if
>>> I CC the openrisc list and Harshita?
>>>
>>> I have to admit, I am not *yet* an expert in formal verification and I
>>> am taking on this mentor role as being more of a guide to the open
>>> source community and learning in general.
>>>
>>> On Sat, Jun 5, 2021 at 10:56 PM Zip CPU <zipcpu@gmail.com> wrote:
>>> >
>>> > Stafford,
>>> >
>>> > I don't really have an e-mail for your student (mentee?), nor do I
>>> necessarily wish to have a longer twitter discussion in a public forum
>>> which might discourage your student, but I thought she (?) might appreciate
>>> some feedback.
>>> >
>>> > 1. When verifying memory or caches, it helps to "sample" the memory.
>>> That is, don't verify the entire memory, just verify a single address (or
>>> sometimes two).  This will make the proof run a lot faster, and as long as
>>> you let the solver pick the address arbitrarily it will be equivalent to
>>> the whole thing.  You definitely want to avoid the "for" loop over all
>>> memory, asserting some feature of it.  Feel free to check out my blog
>>> article on formally verifying memory for more on this and verifying cache
>>> implementations.
>>> >
>>> > https://zipcpu.com/zipcpu/2018/07/13/memories.html
>>>
>>> Thanks, yes, I have looked at that, and I think Harshita has too.  I
>>> wondered how to deal with the assume for the single memory address
>>> when verifying in a larger design.  Should we change that assume to an
>>> assert?  Or should we disable the single address verification when
>>> doing larger designs?
>>>
>>> >
>>> > 2. You really need to put some work into "interface definitions", or
>>> perhaps I should call them custom interface files.  These are files
>>> describing an interface formally.  That way, you can list out the
>>> assumptions used by one module, and then verify (i.e. assert) that those
>>> assumptions are valid in the other.  For a good CPU->memory interface,
>>> whether instruction or data, it shouldn't matter to the CPU how that
>>> interface is implemented--whether cache or other.  The CPU should have the
>>> same interface both ways, but the memory interface itself will bridge that
>>> interface to the bus.  A custom interface file between the two would work
>>> wonders to making sure both components work.
>>> >
>>> > I recently rebuilt the interface property files controlling the
>>> ZipCPU's interface with instruction and data memory.  You can find those
>>> new/updated files here for reference if you would like:
>>> >
>>> > https://github.com/ZipCPU/zipcpu/blob/zipcore/bench/formal/ffetch.v
>>> (I-Mem)
>>> > https://github.com/ZipCPU/zipcpu/blob/zipcore/bench/formal/fmem.v
>>> (D-Mem)
>>>
>>> That said, I wondered what these extra files were and I can see great
>>> benefit now.  Especially also things like fwb_master / fwb_slave which
>>> we could probably used.
>>> There might be good candidates for separate fusesoc cores actually.
>>> Those I found here:
>>>
>>>   https://github.com/ZipCPU/zipcpu/blob/master/rtl/ex/fwb_master.v
>>>   https://github.com/ZipCPU/zipcpu/blob/master/rtl/ex/fwb_slave.v
>>>
>>> Then used like here:
>>>
>>>
>>> https://github.com/ZipCPU/zipcpu/blob/master/rtl/peripherals/zipcounter.v#L141-L146
>>>
>>> >
>>> > 3.  Your student mentioned "Initial assumptions" ... ahm, be _very_
>>> careful about assuming anything.  All it takes is one bad assumption and
>>> you can convince yourself that a broken design actually works.  I like to
>>> say it will "void your proof", but that's what I mean by it.  Ideally, all
>>> assumptions will be captured in interface property files (of some sort)
>>> that then get asserted by whatever is holding the other half of the
>>> interface.  When I teach formal methods, one of the things I foot stomp is
>>> that all assumptions should be audited.  As for the _initial_ in the blog
>>> mention of "initial assumptions", ... you really shouldn't need to
>>> initially assume anything more than an initial reset.
>>>
>>> That's a good point to drill in.
>>>
>>> > 4. A key rule to formal, one I foot stomp a lot and come back to over
>>> and again in the course is that you should assume properties of inputs, and
>>> assert properties of outputs and any internal variables.  *NEVER* assume
>>> anything internal to a module.  That *will* void any proof.
>>>
>>> That makes sense, in other words we could assume inputs will be
>>> presented in a certain way i.e. assume a reset, or assume write_enable
>>> and read_enable will not go high at the same time.  But those
>>> assumptions must change to assertions when verifying the larger
>>> design.  Or those should be left to an interface definition.
>>>
>>> > 5. A key component to any proof of a CPU, interconnect, and any
>>> associated bus components, is a common bus interface property file.  Why?
>>> Because the bus is a common interface--it's not a special or specific one.
>>> That means the effort required to develop a single interface file can go a
>>> long way into making sure every component follows the same rules of the
>>> road.
>>> >
>>> > I built such an interface file for Wishbone 3 sometime ago.
>>> >
>>> >
>>> https://github.com/ZipCPU/wb2axip/blob/master/bench/formal/fwbc_slave.v
>>> and
>>> >
>>> https://github.com/ZipCPU/wb2axip/blob/master/bench/formal/fwbc_master.v
>>> > (Run a diff on these two files to see why I call them one file ...)
>>>
>>> Ah, just what I mentioned before.  This makes sense.
>>>
>>> > I tried at one point to verify OpenRISC's caches with this interface
>>> file and ... I was unsuccessful.  OpenRISC doesn't quite have the same
>>> definition of Wishbone as I have from reading the spec.  At the time, I
>>> didn't dig any further to know which of the two was right and which was
>>> wrong.  I'd personally recommend either updating that property file to
>>> match what OpenRISC is expecting of the bus, or fixing OpenRISC if you
>>> decide instead that it isn't specification compliant.  (Both are possible,
>>> I don't know which is actually the case.)
>>>
>>> Got it.
>>>
>>> > 6. At one time I used the restrict() keyword a couple times.  I've
>>> since had to remove it from any of my designs that had used it.  While the
>>> restrict keyword is supported by the open source tool chain, its support
>>> doesn't follow the SV standard.  I'd therefore recommend not using it.
>>> It's ... just not worth the hassle, and a good assume statement will do
>>> just about as much.
>>> >
>>> > 7. You should also avoid yosys' "chparam" command.  Use the
>>> "hierarchy" command instead once instead for all parameter adjustments.
>>> You may need to do some Python work to get that to work properly.  Here's
>>> an example you might find valuable:
>>> >
>>> >
>>> https://github.com/ZipCPU/zipcpu/blob/zipcore/bench/formal/zipcore.sby#L42-L54
>>>
>>> Thanks.
>>>
>>> > Finally, let your student know that I am available on Freenode's IRC
>>> for questions.  (Yes, I use Libera.Chat and Gitter as well ...)  She can
>>> look me up on either the #openarty or #zipcpu channels, and I'd be happy to
>>> answer questions she might have.  (I'm also available on ##fpga, ##verilog,
>>> and others if she'd rather have a more open discussion.)
>>>
>>> She is also on Gitter that might be easiest.
>>>
>>> -Stafford
>>>
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210606/868aa58c/attachment.htm>
