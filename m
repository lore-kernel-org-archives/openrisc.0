From: Richard Henderson <rth@twiddle.net>
Date: Mon, 5 Nov 2018 19:45:58 +0000
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181104090544.GB16938@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
 <20181104090544.GB16938@lianli.shorne-pla.net>
Message-ID: <c5039c2b-f32e-0ead-cb92-72737e170f06@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 11/4/18 9:05 AM, Stafford Horne wrote:
> I have had some inqueries into helping
> bootstrap some linux nommu machines.

For nommu, we'd need to implement an FDPIC ABI.

Otherwise, code segments cannot be mapped separately
from data segments.  I believe that the arm (32bit)
port has recently added support for this, so you may
be able to find patches from which to crib.


r~
