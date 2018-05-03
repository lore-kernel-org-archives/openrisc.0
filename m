From: Burkay =?unknown-8bit?q?Sab=C4=B1rs=C4=B1z?= <burkaysabirsiz@gmail.com>
Date: Thu, 3 May 2018 03:36:07 +0300
Subject: [OpenRISC] Data cache forcing thaw on pipeline,
 causing cancellation of delay slot insn. Why?
Message-ID: <CAFvNzgNgG45vqgixdoh5xicx6-21qxUSuWvSZUk_OyfeMAxd2Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

 My final year project is to prepare a document on the Openrisc source
code. As I  read and understand the source, I comment it and draw diagrams
which show the inner workings of the modules and their interconnections. If
we understand it sufficiently, we will put our commented version to the
internet, together with the diagrams.


Mostly, the source follows the pipelined processor described in Henessy and
Patterson's textbook, and it is very easy to understand. Unfortunately,
there are a few mysterious signals whose purpose are totally opaque to us.
Two signals in particular are very hard to interpret: wait_lsu and
lsu_unstall. So I ventured to ask about them here..


lsu_unstall seems to work like this: if here is if_stall and lsu_stall at
the same time, but lsu unit thaws without if unit thawing (e, no
icpu_ack_i), lsu_unstall moves the whole pipeline for one cycle, and
inserts a {`OR1200_OR32_NOP, 26'h061_0000}. In case this nop is inserted
between a jump instruction and the following delay slot, no_more_dslot
signal is not asserted when the jump instruction comes to the execution
stage.

Question 1: is this interpretation correct?
Question 2: If correct, why we thaw the pipeline for just one cycle when
data from dcache arrives?

Question 3: What is the race condition that gave rise to the wait_lsu
signal? That race condition must be very subtle, as wait_lsu is added to
the source much later. I have found some discussion of wait_lsu on internet
but I couldnt understand it fully.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180503/1ebaecf1/attachment.html>
