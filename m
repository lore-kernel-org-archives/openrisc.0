From: Stafford Horne <shorne@gmail.com>
Date: Thu, 5 Aug 2021 10:00:01 +0900
Subject: [OpenRISC] mor1kx licensing
In-Reply-To: <CADzBsGPE=YaKcR9_37iPHk=hwapDar1tV8mkxudmh1v6H4j+EA@mail.gmail.com>
References: <CAF6YiZ5Hsc-mf_s5bBVQ5+gRQ1++rC=HP5XT2mwyygEjs_1gqw@mail.gmail.com>
 <CADzBsGPE=YaKcR9_37iPHk=hwapDar1tV8mkxudmh1v6H4j+EA@mail.gmail.com>
Message-ID: <CAAfxs77xhSeM-QPYsEr7t-gEVO2+w9EchESAE44XMUcJp37=8Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I agree as well, CERN-OHL-W sounds right.  Also, to do the change a PR
updating all the files headers and the license file would be the way
to do it.

CCing Andrey as well and he did a lot of work on mor1kx FPU and other parts.

On Wed, Aug 4, 2021 at 1:32 PM Stefan Kristiansson
<stefan.kristiansson@saunalahti.fi> wrote:
>
> I'm in favor, and I agree that CERN-OHL-W sounds like the right flavor.
>
> On Wed, Aug 4, 2021 at 6:50 AM Julius Baxter <juliusbaxter@gmail.com> wrote:
>>
>> Hello fellow mor1kx developers,
>>
>> I've been meaning to do this for a while, but I'd like to propose we switch the licence of the mor1kx to the CERN OHL v2, and then I can EOL the OHDL.
>>
>> There are 3 types of the OHL v2 licence, basically 1) strongly reciprocal, 2) weakly reciprocal, and 3) permissive.
>>
>> In the spirit of the OHDL the mor1kx is currently licensed under, I'd suggest we go with the weakly-reciprocal licence, the CERN-OHL-W.
>>
>> The OHWR site has a nice FAQ describing the difference between these v2 flavours:
>> https://ohwr.org/project/cernohl/wikis/faq#q-what-are-all-these-suffixes
>>
>> The idea behind the OHDL was that it'd be file-level copyleft, just like the MPL (or at least as I interpreted it) it was based on (via m-x query-replace in Emacs :-P ). I think it'd be good to back the work Javier and Andrew and Miriam have done with our own work.
>>
>> I'm copying the OpenRISC list because I guess I want to make sure any contributor from the past gets a heads up, too.
>>
>> This is the first time I've done something like this, so am not too familiar with the process. Should I just do a PR on github and we can debate it on there?
>>
>> Anyway, I'm interested in your thoughts. Feel free to contact me off list if you prefer. Unless anyone objects, I'll do a PR relicensing the IP in the coming week or so.
>>
>> Cheers,
>> Julius
