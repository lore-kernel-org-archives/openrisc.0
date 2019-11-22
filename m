From: ecalvo@2se.es <ecalvo@2se.es>
Date: Fri, 22 Nov 2019 14:41:25 +0100
Subject: [OpenRISC] tick timer doubt
Message-ID: <00a201d5a13a$89b42f80$9d1c8e80$@2se.es>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi!!

 

I have some doubts about the tick timer. Could someone help me? I explain
them below

 

*	I don't understand really well the example of or1k timer control
that is in that file: For example, how is ticks variable updated? 
*	If it was updated, I understand that if frequency is 100Hz, a new
tick takes place each 0.01 seg and with 100 ticks, a second has elapsed.
However, If I compile and run this code and, and I open with gtkwave the
generated vcd, I don't understand why the value of TTMR register is 1000000.
Is The value of TTMR register fixed by software using or1k_timer_set_period
function? Is it measured in Hz?

 

Thanks in advance

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191122/85f0c147/attachment.html>
