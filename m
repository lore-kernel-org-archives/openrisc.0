From: ecalvo@2se.es <ecalvo@2se.es>
Date: Mon, 25 Nov 2019 11:09:03 +0100
Subject: [OpenRISC] tick timer doubt
In-Reply-To: <CAAfxs75RqOV_0BVB_-5uyFjJrK2fFqU-_-rtQq65yy4EN0KgTQ@mail.gmail.com>
References: <00a201d5a13a$89b42f80$9d1c8e80$@2se.es>
 <CAAfxs75A61B8H8iBS1ibXo2SGg=fY9jBjsNAucSFASBVP=rp+g@mail.gmail.com>
 <00b501d5a369$2b89ea90$829dbfb0$@2se.es>
 <CAAfxs75RqOV_0BVB_-5uyFjJrK2fFqU-_-rtQq65yy4EN0KgTQ@mail.gmail.com>
Message-ID: <00e601d5a378$5e11b740$1a3525c0$@2se.es>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Okk, but, independently of the ticks variable updating,  ttmr register… should it have the value that has been configured with  <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga432f34016f4f559c29b0be4fbc87e623> or1k_timer_init?

 

 

De: Stafford Horne <shorne@gmail.com> 
Enviado el: lunes, 25 de noviembre de 2019 10:22
Para: ecalvo at 2se.es
CC: Openrisc <openrisc@lists.librecores.org>
Asunto: Re: [OpenRISC] tick timer doubt

 

Good point,

 

I think it's missing a line to update the ticks variable.

 

I terms of ttmr I am not sure if there is anything won't there.  I'll try to run it and fix it when I get a chance.

 

On Mon, Nov 25, 2019, 5:20 PM < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:

Hello, 

 

 

Yeah, I think that I have understood what you have sent me in the screenshot. 

 

The example that I am referring is this one: 

 

Example for using the default mode:

int main() {

uint32_t ticks = 0;

uint32_t timerstate;

 <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga432f34016f4f559c29b0be4fbc87e623> or1k_timer_init(100);

 <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga369138d63850f2a4dfe216315c31f3d4> or1k_timer_enable();

while (1) {

while (ticks ==  <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga2baa18c5153c793b7d2a85c6e224cea0> or1k_timer_get_ticks()) { }

timerstate =  <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#gab40473a360aa82273575cdbc4381ac93> or1k_timer_disable();

// do something atomar

 <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga0e392edcf73b9cf1c0279471ae59d241> or1k_timer_restore(timerstate);

if (ticks == 100) {

printf("A second elapsed\n");

 <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#ga456bc40cdfbbbdfd62c936c065457cc2> or1k_timer_reset_ticks();

ticks = 0;

}

}

}

It is in the file and also here:  <https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#gaf760867d2f9d04f0c101c4c4975b0616> https://www.openrisc.io/newlib/docs/html/group__or1k__timer.html#gaf760867d2f9d04f0c101c4c4975b0616

 

Elisa

 

De: Stafford Horne <shorne at gmail.com <mailto:shorne@gmail.com> > 
Enviado el: domingo, 24 de noviembre de 2019 1:05
Para: ecalvo at 2se.es <mailto:ecalvo@2se.es> 
CC: Openrisc <openrisc at lists.librecores.org <mailto:openrisc@lists.librecores.org> >
Asunto: Re: [OpenRISC] tick timer doubt

 

Hello,

 

Which example are you referring to?  Have you been able to read the architecture specification and understand section 15 on tick timer facility?  There ttmr is explained, the value 10000000 I think indicates a pending timer interrupt.

 

See the attached screenshot.

 

-stafford

 

On Fri, Nov 22, 2019, 10:41 PM < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:

Hi!!

 

I have some doubts about the tick timer. Could someone help me? I explain them below

 

*	I don’t understand really well the example of or1k timer control that is in that file: For example, how is ticks variable updated? 
*	If it was updated, I understand that if frequency is 100Hz, a new tick takes place each 0.01 seg and with 100 ticks, a second has elapsed. However, If I compile and run this code and, and I open with gtkwave the generated vcd, I don’t understand why the value of TTMR register is 1000000. Is The value of TTMR register fixed by software using or1k_timer_set_period function? Is it measured in Hz?

 

Thanks in advance

_______________________________________________
OpenRISC mailing list
 <mailto:OpenRISC@lists.librecores.org> OpenRISC at lists.librecores.org
 <https://lists.librecores.org/listinfo/openrisc> https://lists.librecores.org/listinfo/openrisc

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191125/083c3010/attachment.html>
