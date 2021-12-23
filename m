From: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 23 Dec 2021 16:57:56 +0100
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <YcSZ0iyC6STzh9uP@antec> (Stafford Horne via Libc-alpha's message
 of "Fri, 24 Dec 2021 00:46:26 +0900")
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
 <Ybl/E2BWBGRMwF0G@antec> <YcSZ0iyC6STzh9uP@antec>
Message-ID: <87pmpnnwjf.fsf@igel.home>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Dez 24 2021, Stafford Horne via Libc-alpha wrote:

> It seems the write to the tmp file was failing due the re-open not passing
> O_LARGEFILE.

open64 implies O_LARGEFILE, so if that is making a difference, then your
open64 is broken.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
