From: Stafford Horne <shorne@gmail.com>
Date: Sun, 24 Nov 2019 09:04:39 +0900
Subject: [OpenRISC] tick timer doubt
In-Reply-To: <00a201d5a13a$89b42f80$9d1c8e80$@2se.es>
References: <00a201d5a13a$89b42f80$9d1c8e80$@2se.es>
Message-ID: <CAAfxs75A61B8H8iBS1ibXo2SGg=fY9jBjsNAucSFASBVP=rp+g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello,

Which example are you referring to?  Have you been able to read the
architecture specification and understand section 15 on tick timer
facility?  There ttmr is explained, the value 10000000 I think indicates a
pending timer interrupt.

See the attached screenshot.

-stafford

On Fri, Nov 22, 2019, 10:41 PM <ecalvo@2se.es> wrote:

> Hi!!
>
>
>
> I have some doubts about the tick timer. Could someone help me? I explain
> them below
>
>
>
>    - I don’t understand really well the example of or1k timer control
>    that is in that file: For example, how is ticks variable updated?
>    - If it was updated, I understand that if frequency is 100Hz, a new
>    tick takes place each 0.01 seg and with 100 ticks, a second has elapsed.
>    However, If I compile and run this code and, and I open with gtkwave the
>    generated vcd, I don’t understand why the value of TTMR register is
>    1000000. Is The value of TTMR register fixed by software using
>    or1k_timer_set_period function? Is it measured in Hz?
>
>
>
> Thanks in advance
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191124/c5c87706/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot_20191124-085931.png
Type: image/png
Size: 158182 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191124/c5c87706/attachment-0001.png>
