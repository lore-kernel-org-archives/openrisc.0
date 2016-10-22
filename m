From: Stafford Horne <shorne@gmail.com>
Date: Sat, 22 Oct 2016 16:56:57 +0900
Subject: [OpenRISC] OpenRISC isa changes proposal
In-Reply-To: <c1120129-7537-31b2-394b-c1c09720bb76@embecosm.com>
References: <CAFukJ-C7TYtzkszLZEMSgS=io6NnyLcX5mOzq=kZGHH7M1w7_A@mail.gmail.com>
 <c1120129-7537-31b2-394b-c1c09720bb76@embecosm.com>
Message-ID: <CAAfxs77Pe9Cea0WWXTQaJn32mJVHVoehUVdKsneG7ScObfiZGQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Oct 15, 2016 at 11:57 PM, Jeremy Bennett
<jeremy.bennett@embecosm.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/10/16 20:23, Alexey Baturo wrote:
>> Hi, everyone!
>>
>> I've been looking at openrisc isa recently, especially at orvdx
>> part and have some ideas to improve it.
>>
>> First of all, there is no ORVDX32 extention and I don't see why
>> shouldn't we have it? It would not be very efficient, but why not?
>>
>> Next one is related to vector instructions encoding. Let's say
>> there are 2 types of vector instructions: the ones who operate on
>> bytes and another operate on vector. To distinguish them it would
>> be useful to assume the byte ones have LSB of 0 and 1 for halves.
>> To do that we have to slightly tune the encoding: i.e. make
>> lv.avg.b and lv.avg.h be encoded with 0x38 and 0x39 respectively,
>> instead of 0x39 and 0x3a. I could provide suggested list of
>> changes.
>
> Hi Alexey,
>
> I wish you well with this project. Although the original spec included
> a set of vector instructions, I don't remember anyone ever
> implementing them. IIRC they were never added to Or1ksim either.
>
> So you should have plenty of scope to refine the details of the spec.
>

Hello,  just FYI, I sent a previous mail about moving the architecture
proposal process over to openrisc.io.  I just sent a pull request [1]
to add the new process on openrisc.io/architecture.

Once/If the pull request is accepted. This might be a good candidate
for using and giving any feedback on the new process.

[1] https://github.com/openrisc/openrisc.github.io/pulls

-Stafford

