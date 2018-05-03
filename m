From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Thu, 3 May 2018 15:20:08 +0100
Subject: [OpenRISC] OpenRISC Digest, Vol 27, Issue 1
In-Reply-To: <CAFvNzgPOqLMUzARBqyUco2eaeDJYeJPN=Ecw9P3jq=zo6gUq-Q@mail.gmail.com>
References: <mailman.1.1525341601.9004.openrisc@lists.librecores.org>
 <CAFvNzgPOqLMUzARBqyUco2eaeDJYeJPN=Ecw9P3jq=zo6gUq-Q@mail.gmail.com>
Message-ID: <6100dbd6-c519-3ef3-8be4-7b1c224e70a3@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am pretty certain this is the original OR1200 implementation, which
is nearly 20 years old! You'll see the last patch was well over two
years ago!

I recommend you work on mor1kx:

  https://github.com/openrisc/mor1kx

It is much more up to date. I don't know if there are more recent
implementations.

Best wishes,


Jeremy

On 03/05/18 11:24, Burkay Sabırsız wrote:
> Thank you for your return.
> 
> I am working on OR1200, the version available at 
> https://github.com/openrisc/or1200
> 
> 2018-05-03 13:00 GMT+03:00 <openrisc-request@lists.librecores.org 
> <mailto:openrisc-request@lists.librecores.org>>:
> 
> Send OpenRISC mailing list submissions to 
> openrisc at lists.librecores.org 
> <mailto:openrisc@lists.librecores.org>
> 
> To subscribe or unsubscribe via the World Wide Web, visit 
> https://lists.librecores.org/listinfo/openrisc 
> <https://lists.librecores.org/listinfo/openrisc> or, via email,
> send a message with subject or body 'help' to 
> openrisc-request at lists.librecores.org 
> <mailto:openrisc-request@lists.librecores.org>
> 
> You can reach the person managing the list at 
> openrisc-owner at lists.librecores.org 
> <mailto:openrisc-owner@lists.librecores.org>
> 
> When replying, please edit your Subject line so it is more
> specific than "Re: Contents of OpenRISC digest..."
> 
> 
> Today's Topics:
> 
> 1. Data cache forcing thaw on pipeline, causing cancellation of 
> delay slot insn. Why? (Burkay Sabırsız) 2. Re: Data cache forcing
> thaw on pipeline, causing cancellation of delay slot insn. Why?
> (Jeremy Bennett)
> 
> 
> ----------------------------------------------------------------------
>
>  Message: 1 Date: Thu, 3 May 2018 03:36:07 +0300 From: Burkay
> Sabırsız <burkaysabirsiz@gmail.com 
> <mailto:burkaysabirsiz@gmail.com>> To:
> openrisc at lists.librecores.org
> <mailto:openrisc@lists.librecores.org> Subject: [OpenRISC] Data
> cache forcing thaw on pipeline, causing cancellation of delay slot
> insn. Why? Message-ID:
> 
> <CAFvNzgNgG45vqgixdoh5xicx6-21qxUSuWvSZUk_OyfeMAxd2Q@mail.gmail.com
>
> 
<mailto:CAFvNzgNgG45vqgixdoh5xicx6-21qxUSuWvSZUk_OyfeMAxd2Q@mail.gmail.com>>
> Content-Type: text/plain; charset="utf-8"
> 
> My final year project is to prepare a document on the Openrisc
> source code. As I  read and understand the source, I comment it and
> draw diagrams which show the inner workings of the modules and
> their interconnections. If we understand it sufficiently, we will
> put our commented version to the internet, together with the
> diagrams.
> 
> 
> Mostly, the source follows the pipelined processor described in 
> Henessy and Patterson's textbook, and it is very easy to
> understand. Unfortunately, there are a few mysterious signals whose
> purpose are totally opaque to us. Two signals in particular are
> very hard to interpret: wait_lsu and lsu_unstall. So I ventured to
> ask about them here..
> 
> 
> lsu_unstall seems to work like this: if here is if_stall and 
> lsu_stall at the same time, but lsu unit thaws without if unit
> thawing (e, no icpu_ack_i), lsu_unstall moves the whole pipeline
> for one cycle, and inserts a {`OR1200_OR32_NOP, 26'h061_0000}. In
> case this nop is inserted between a jump instruction and the
> following delay slot, no_more_dslot signal is not asserted when the
> jump instruction comes to the execution stage.
> 
> Question 1: is this interpretation correct? Question 2: If correct,
> why we thaw the pipeline for just one cycle when data from dcache
> arrives?
> 
> Question 3: What is the race condition that gave rise to the
> wait_lsu signal? That race condition must be very subtle, as
> wait_lsu is added to the source much later. I have found some
> discussion of wait_lsu on internet but I couldnt understand it
> fully. -------------- next part -------------- An HTML attachment
> was scrubbed... URL: 
> <http://lists.librecores.org/pipermail/openrisc/attachments/20180503/1ebaecf1/attachment-0001.html
>
> 
<http://lists.librecores.org/pipermail/openrisc/attachments/20180503/1ebaecf1/attachment-0001.html>>
> 
> ------------------------------
> 
> Message: 2 Date: Thu, 3 May 2018 08:53:19 +0100 From: Jeremy
> Bennett <jeremy.bennett@embecosm.com 
> <mailto:jeremy.bennett@embecosm.com>> To:
> openrisc at lists.librecores.org
> <mailto:openrisc@lists.librecores.org> Subject: Re: [OpenRISC] Data
> cache forcing thaw on pipeline, causing cancellation of delay slot
> insn. Why? Message-ID:
> <8db08802-b9d8-4e78-b98e-681e6f1b9e62@embecosm.com 
> <mailto:8db08802-b9d8-4e78-b98e-681e6f1b9e62@embecosm.com>> 
> Content-Type: text/plain; charset=utf-8
> 
> On 03/05/18 01:36, Burkay Sabırsız wrote:
>> My final year project is to prepare a document on the Openrisc 
>> source code. As I  read and understand the source, I comment it
>> and draw diagrams which show the inner workings of the modules
>> and their interconnections. If we understand it sufficiently, we
>> will put our commented version to the internet, together with
>> the diagrams.
> 
> Hi Burkay,
> 
> Good luck with this project. I look forward to your documentation 
> being published, since it will help many others.
> 
> You need to be clear which version of OpenRISC you are working
> from, since it continues to be refined. I believe the latest
> implementation is Julius Baxter's mor1kx, but others on this
> mailing list can give you a definitive guide.
> 
> Best wishes,
> 
> 
> Jeremy
> 
> 
>> Mostly, the source follows the pipelined processor described in 
>> Henessy and Patterson's textbook, and it is very easy to 
>> understand. Unfortunately, there are a few mysterious signals
>> whose purpose are totally opaque to us. Two signals in particular
>> are very hard to interpret: wait_lsu and lsu_unstall. So I
>> ventured to ask about them here..
> 
> 
>> lsu_unstall seems to work like this: if here is if_stall and 
>> lsu_stall at the same time, but lsu unit thaws without if unit 
>> thawing (e, no icpu_ack_i), lsu_unstall moves the whole pipeline 
>> for one cycle, and inserts a {`OR1200_OR32_NOP, 26'h061_0000}.
>> In case this nop is inserted between a jump instruction and the 
>> following delay slot, no_more_dslot signal is not asserted when
>> the jump instruction comes to the execution stage.
> 
>> Question 1: is this interpretation correct? Question 2: If
>> correct, why we thaw the pipeline for just one cycle when data
>> from dcache arrives?
> 
>> Question 3: What is the race condition that gave rise to the 
>> wait_lsu signal? That race condition must be very subtle, as 
>> wait_lsu is added to the source much later. I have found some 
>> discussion of wait_lsu on internet but I couldnt understand it 
>> fully.
> 
> 
>> _______________________________________________ OpenRISC mailing 
>> list OpenRISC at lists.librecores.org
> <mailto:OpenRISC@lists.librecores.org>
>> https://lists.librecores.org/listinfo/openrisc
> <https://lists.librecores.org/listinfo/openrisc>
> 
> 
> 
> 
> ------------------------------
> 
> Subject: Digest Footer
> 
> _______________________________________________ OpenRISC mailing
> list OpenRISC at lists.librecores.org
> <mailto:OpenRISC@lists.librecores.org> 
> https://lists.librecores.org/listinfo/openrisc 
> <https://lists.librecores.org/listinfo/openrisc>
> 
> 
> ------------------------------
> 
> End of OpenRISC Digest, Vol 27, Issue 1 
> ***************************************
> 
> 
> 
> 
> _______________________________________________ OpenRISC mailing
> list OpenRISC at lists.librecores.org 
> https://lists.librecores.org/listinfo/openrisc
> 

- -- 
Tel:     +44 (1590) 610184
Cell:    +44 (7970) 676050
SkypeID: jeremybennett
Twitter: @jeremypbennett
Email:   jeremy.bennett at embecosm.com
Web:     www.embecosm.com
PGP key: 1024D/BEF58172FB4754E1 2009-03-20
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlrrGpgACgkQvvWBcvtHVOFcmwCeNr3+6mCWE+zjMEi8T9bP1gPD
lGkAn2PIo1pxmLvHoAulQcaVsN/ybfLq
=zbSJ
-----END PGP SIGNATURE-----
