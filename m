Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEF1FC111;
	Sat, 22 Mar 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658081; cv=none; b=LHNe1akpJYfmFdHdAbZBawHbwB+z/e4fW768M/qlPeeiv+Va8VmNN0Z0Cdaj+Ez74WB0+bLkdMmEv2hQwC4azEEhHb/BhKyltXFEjp2MWo8ww5AScU8hXs2xCGKKvh62I8uhkyF+X22IBUlWPi+BJRxseiE4s11CooyeCLz9nwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658081; c=relaxed/simple;
	bh=yBsJdEaL0lHYY7uQaEKOkXXNSi/IF0RzWIcvS08y2bk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LKtvw8VjbdQN4nBYUUHQoOu19E+kigEZwF00DXROtJJC717cw8zUbU9VUSJCv6bViHjSOFVdP2bX4CAwOGNXB2XarDoofH/b89+vynwH2uwoe+rxt8rQztm+jIU6LaGaALt39Xw43C8NXSRfC0LzRMZS7lnfCDiEF8+sIDb7Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KkibrdrM; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KkibrdrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742658062; x=1743262862; i=markus.elfring@web.de;
	bh=yBsJdEaL0lHYY7uQaEKOkXXNSi/IF0RzWIcvS08y2bk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KkibrdrMZ1SOaDOGeJ1RFcgLHg2kqt0XvdNbkpGyn0jWSOMXgBT3xAR/xkZfnH3m
	 Nc4lYxk5+9FQLfD9UqCOGmbij63q9x8+HpKTWLdbHXzvjCZBVya3YFXIdMsoH5E25
	 BHXlXVy9CDgu233WZZLC9bx0Df6gH8CmuoXgetkqzQ9Cm56GukvwCI9KwuCnXu6z0
	 3G1lal3na2d9CwbqiFXPInXt3JjqlEmUauqsIlXQb9ZmTmfojC9nfyuIMVwgNjzwx
	 63Oe98we03cEpmVWsx3pDHWdFfufueYoX6UwnqKWYXIWGDkgRjo/os9suuB7frFo/
	 qfIUKqgWDpBSTVo0sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1tO4Kx3Fhl-00ZCpW; Sat, 22
 Mar 2025 16:41:02 +0100
Message-ID: <b5374b26-ccff-4ce9-8500-8b3da427be83@web.de>
Date: Sat, 22 Mar 2025 16:40:59 +0100
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sahil Siddiq <sahilcdq@proton.me>, linux-openrisc@vger.kernel.org
Cc: Sahil Siddiq <icegambit91@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stafford Horne <shorne@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
References: <20250315203937.77017-1-sahilcdq@proton.me>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250315203937.77017-1-sahilcdq@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d+eZTTnpFfK8HwrJ8q+nM6IOgyDfuwp/7EZO1EPNQSGrZsC8wG8
 MqFQ+tboD9BDNgbwlsQBxNfeEQXwGJsRdM7xDfRYiLtfi0tmSip0vOVn08t6tq5/f238eGy
 ilH/8waD1l7FgeRVRvO3BXSP/FzI8oCAE1dUBhggTB/MTlCERHmBMQqPGKEY8KyDYfCSFEp
 k1o+vcpW6+l+SIiNvNrKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5yR82eWG0/I=;zjWMpkCK/BOmwmIPc2Py6J2sKTq
 7pBxf0elnUbE9bl7lgSrcOt1sMM3oeVlng2BCId/fWTkNvR+ZE6P8G2DjcqYmJBWsQZp0qiTl
 1c414wGlzHyx1GynQbsMoxEVKLEU2CCF+ErbFbikUow6Gqyo303d7dzIsMZ9VOhboxUbPvqes
 xk0tBCmGu1l9s2Du5IfpFw8IFjriM/Wpg96IDRduKBfYrkSfpMWPln3nmz1RqpfXiXLk0OoN1
 7CeFJzQ8XuuYFkRHXoq73R8kpUGN/20f4JjvES1Wwu6s6mUbQVZb673TjXN4KBTh7ZoZoQb+/
 lTR5wYTkIi2Nxd/SLtaqIFww/tU3Y5Ory/gQ5zMyC56zKXoUe7MNry3LQenj9wOEOM/Y/cFh6
 QUBff6tHOlgUMWgF4xpCfadFNQyLjf8Htrilq/7KxKRamYf18POjBoWpHRWKYShhZ4gohKuS0
 Az4ytJ8veIH9HQTaemGGXE1z1PBgX8cLIe9huw9xU/d0kbKrB+SKXrT95c22W0G+qg4tmgnkE
 FZ6oKDK/C4vcBxg+9YSzyhki7msaV7ZcAk77sYr4DJ1ITyaBHbNQUGDrzcniyLj/C8ilv//FS
 3m1RJEMz653M56EoJRDLCAiu7NZMpSJp6P5It65joFMr5y4HF3iwUstWdc+yUPUMsRcrA9ZyQ
 FYRCb0n1K+LVsx1KtfWzwXvzOkEl7bh0lDfoEHwr/c2uccNYJp01OHCBWop+9uHG7lK8OrqWI
 SCpv9GOu0ldalIuqDoSh6cGUzs1Y2lP7wFeEDutv2vxPSoUI2wZVNSomgztD7vClaShUjWTtg
 lij4cZIsXTdBLlA5aHWDH3UGhTdjskVshuefuhFtqopTtcHKajDSTS4+fjmN1IAIG1jLgfo9H
 TfmKzzR4Vu5qufqd1W1VnZXmVoa9/UNPqPp/ASoNbQKne1jdKVAOWX+JyLXUv2lni2RsnMBXs
 wxpZfisjHko03zQL+ePfcN0WiBdvYDDuLiWteypBLfC7nGkaxYnA3xbIdczg8srAtexwXthT8
 E6iLpHdBM/YzfWqS6tB4YdeZDtFXhLQHC2Ul+msvOYYPzrBtbUkbPw879ZtIJvcSgLLE7XDJF
 9mADt932n2BUwg+dgnu0YghcIPlQvATRmyIpHSmifYPI2FeC1xbPHpSZvBoRfAqysl3GPz88r
 FHEWfgUYX6u8RA6pC8P+fjBYIlghcUnx/D+Qlpnw8Cxp01+Qel34p70EuyDAw63RbcnyCo+Ei
 PmP4CsyXcY1oJ428+KkAIpN/c1GzxGiKXAPvbxZIUQNXU8ap3DElpgmJKtHEYSdyOXbeyNglC
 Tj/vIkE1nHbiQdqeFV/BzbCPJTs0wYGzR2we0lnSQ5GCq8oNiUvZ5WWhocxtYJtlJi4OgqvgI
 0EzN/jA+e51BTJeplPQKh3yQU2IFwl7q0Xaalp0YlEAUYMPUmv6tQoU0Ig2h2JeNPaWXvUPdA
 OAP2f8iFYpOfAQnLByUxlFCNmeQOHurgHYfcOXl/ITi47ymz49bhR558s43SylS/YNy+xnw==

=E2=80=A6
> This patch provides a mechanism =E2=80=A6

> The patch also moves =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc7#n94

Regards,
Markus
