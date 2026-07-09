Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EA412282
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596051; cv=none; b=GlIOnqjedY0jNFnruhnumlwBG99wpiefTxnAdD3KOvavHvrbbKGJGc/T3f+VpMOLZW4rfyHVPe3yUOzv3/PQZxZ5ys+Ipojwb/XEHH8CcZINEGqIxJ/BPbN4WbdtMI0KhCXoiHbM3kLm2LVa8oGO3oJDNAlXeimlbmCaEPhVAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596051; c=relaxed/simple;
	bh=R+aFi5Oqdv0TDSr7wZR2WAPngeBl4pJ5LsNFoxiZF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7NsetSPneEZDu2q25KQg5coiHdpcKc65aBXuErjuf7me9LD6JyQQz+JBzrzFjTCbwPRDaJ/xKt0VLWYrhAlBit1JlOnUpkkgqzN4/bBDySritxh17qUdnKLnMYJJpSjjWOzIWrvXt2NVumzC1RAo/+9Dvi5Iiu63W7LogdKAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOWfjmK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7clZpL6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOWfjmK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7clZpL6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax4eQ1470725
	for <linux-openrisc@vger.kernel.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3gw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bf321d786so20351731cf.1
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596047; x=1784200847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=a7clZpL6nOtGSdXl/9VMFzxG3FX6J7Jpz5oRTdF3Ud3LP62vUE/2zfduFUE/Wg0Sqm
         w1xkr6dEnyY6T6tXj74TWHvp55bSy7Gu9OSAbXU+V8JTqHMHIG92VFPihlaUxK0k6We6
         suDfZ7lTXPJpRhiIrk/t18bDczgSnwKr7QZYvherjAIymulLlj6kidlUwdc2GZDQ4o40
         7c2tSW0WD7rNUUnlb2XWaPJv+kv92FjKKxiIEgZLP2juJ90L5oEGTKW1vW9KeDnzN+2B
         W4/I9Kif0Idgk83Lb1M2eQkLA1l1kX/2DMrxOMccuXA772LF/TW/pR7thgHMiiY0edpu
         SkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596047; x=1784200847;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=NS1OyBXN1xfyWv1hbK65d1uP5CGoXxiFXkq28csewG966cvTKugUMx/cEjTl7oO9uc
         uoeM0MOAL9Umr8ITGUkeDt7cHHsdVRtEX2XduhbG5tz5e0G9vSmd2pqYWW+DeXZz0lu2
         FfEN1fYpk3mO6mdhzwNpChi1P6q1mMdV38UP88OacJOXOv+yd3iYA3tZVpmWCT0mxQ+O
         3YwnUT5TheCV9EwRyxBJVn5iTw6ZSgORWbjehN+zpqvPRjDYzDRlPBlf5c9LrNvMqiPw
         o/X0SywRJvTqBNJDCZMT9HBfMQPg/LjwDSX7xR668ss5teQuqgytSS6zUY5aKZKluugk
         sTsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDVHyVqemxhM+P9rWXiDbPy+OdHfJnUkraagNYcoBS8jD7R6GO4OQI8txk5AdTTgBq5c3Dc1WjyBFBezTkMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfS0C3XI5QUCEb0iITLtpK6dUG/4DXH1EAJAuyX1pBgmDVAkI
	7Im1s9s7Y+jVUrvBSkOxWQclRGW82JMWGZ6V2XfwU+Chhig7Egu/0jIUfZQppPLzjUffedDc3FV
	1uE14a3zCxhuDGQj0pTmKXfqzVVygzfI0ohbg+aER9jOC4GkeefpKZWDd6bzOpidnIscQvA==
X-Gm-Gg: AfdE7cnhxu6u5sUYHMAtYFdOPKjponzunc9SkNcWKGOgrxWayBHZFBTkV1iIA1MqS07
	jMmdRn2YQqK2s6KEwq85ODRNToCG5rwG6MxHEV+ivBo8PYCYvZFPrB+eNUBADA1vcUcGTklVxZ4
	J3VocbtxUsRgb3tXFok/KOY61jTXF9VM6C8y0TBNsYYQIG9DzjmrPnStk0dHLkCUhFpZzvPVJhL
	Yls4RkWpZsq2IPP3tT0SDmyWTRrIrmjBuZCjzXbWUNXhpj5/6mziOOttx5RrW89S1kCZi+1/k7e
	QO1TMFqsjohiCBa4Iz9IkEOrJM/ibJVORgzpgM9CRrON8enulgW0XomZfaM9s+Tce0VZuJ4uSEs
	OiiSku1KRiSb0EBSZx8SLZ4nsBRPPvSAV2GCa+HvxHKj0zt/+a5W38RxaGMr5qg==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71755041cf.27.1783596047583;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX0B7RI6tfga+U
 zGCU6aOsTRcSi8OFDjHXxwu+xPovvHKmnh02Djpm0qEDuxD8GmG3wrBW/jsLpy2zncoZYJCLF3k
 ro0BswfBkoihkbfG68r0cgb1YZwXXoo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX4HNY/335f44f
 cFRt66UWQG3Jrus1IM5tPM9Iyk4pBN8QKKeuE+P+jPK4F5aJvyM3vmNCIJ4USDE4br3whZPp5uV
 Vay9lRP8T8WGqtFfE1WXNaVSS0lwHvkZbtkzL5ttb0OcWXPKwacmA4d6GINjju6JAwdCKd1B1PK
 dJBEWtxeUpyqkxuZx0LgsnxuFdsg+8gxTVrlyeGmfGZHPXOMIBH7qbAwiWPekiK/1If9Gl+TYNf
 pNQwpY0qMAN1i9i0qEf3PtzGKJrlNsGKLHBeHkb41gor+a3ixfdUnlO11KMbYQ3FtDDiFO+hEYO
 IsWEoPi9mJZAeeM9BM+uSCdZouVCQ8BhmI7r7golJlkJY3vmQClyWlup1LsbKTYAEQmXFBdCHPY
 ZuqwYt2J0h4p3PGZaYgDjSccRkaAUV0P8apCZqYXPZ9HFZ26Q09wJUJS933qxYj+T+i8wjnDC0X
 7aMAge4Mfu+WwSAIoPw==
X-Proofpoint-GUID: I0MnhhUD7goAZ7tmuasDR8utSnkVVviS
X-Proofpoint-ORIG-GUID: I0MnhhUD7goAZ7tmuasDR8utSnkVVviS
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)


