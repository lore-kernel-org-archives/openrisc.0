Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1A40FD87
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595845; cv=none; b=o2bk80p4Xzuxk6HjxopyvCg6ytF/udDVyyCUjERLm0+stsbyvKEV6UQoAWNsiXmUjjBcPVhsH7eaLOoBjJIsDnO9ZUGFpp2SKKuIixDdm3ktJyG1mklGBFkNKopYSFZuxsU2QfXU1EbtssaRvf3Yqkcug3PXdFcRGhsW+qvJoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595845; c=relaxed/simple;
	bh=nrb0ag4EBTliR8HEhFNdNbVVIK/JUBRD2JKlM2G1ar0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUAcz6eXza/na8ItjxTmj1haE4k89Zii3wH+H1Qljt7mmwcM5bI+MDntu8SpeBzGBcF74nrWQ0SPIpkjE3Yt45ivJZik9ayVlhzHfNwmWKGKlc/qOqtzdaL1DTQd/8S0Wx2jH2v6dXGP1lwX02vpvr6NeFWST8xNSib5TBTpL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5+SzP63; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gtO1PuCP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5+SzP63";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gtO1PuCP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AwuME1660683
	for <linux-openrisc@vger.kernel.org>; Thu, 9 Jul 2026 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=; b=L5+SzP63bgPAWhp4
	W0cUVg2l9n9I+4k0Akz43rpejx4oS0/IbbWAmLMXE7C9F37E36sY/GsXk3zuJt0e
	7WRl8xWn74pDgWLAKB7VqpUweKGfDHpjZadrDE/thxVaWuDjHJ729famrINqKMDx
	0upb87A5cv2e3e9cOgTo/VDABpH4Tf/6q96s0WSa2IFCTqdWIxx3GVEJhdklhdir
	gMzNGoVv54cFMR8lTrj5sNzMMQDcUrBjV8bPTBpznG6YMJOrkgy1v18t2RPVEfx/
	2v3dDdCotvg9oshrPidheW6ip0HZ0YECDQHkCxRsQPUi1HLjdw3FRE6oVFrVR41W
	qvGWIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vug46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 11:17:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c075c1e25so8067221cf.3
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595841; x=1784200641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=gtO1PuCPVSA3pcxofYSwzSptyCP8fplhGA0gMAQmi2dxDkJtaOaut5/NCmYMcZ66yp
         ANnNK9rb7kxDIPXzoyfVDt947Ta0of89XonsQf2ieDZ9TcHUuSK7ZKUfimsVYxjXJTJO
         kU43zaFkytMyc1foFpfmHGxGayaY8QZw1+eaUTZKTy4oMk9XSsJBa32zlN6H29CVuyNA
         rSSfYeAf1jGHIDl5pyypQVfyjMATyRCcOiIdur5rcViEEVLFcOtNuI1/WYo9Ufcvo0Rn
         vPZTO8rXfaXRIYTdSlFwq71J1495hyT9KjxVzsTQBjzpTY1aK9RZGnpINh1izwamCSLB
         k9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595841; x=1784200641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=Nqd/fmQTWtEZ2d+Vnlpega3RPwbdvWU5yF1YmS1WJbT5QN3KdQSxtRK9AgUP8xc41B
         qvf824NBHfFS3m692zyPMffBuS6+RUDvDMZyhD/0euGWmGiohK6l2l7+s5FTKmVIhteg
         IIdfjYalxR3hHSCakHk8554SqMiWpn7mLyVROU1AGKEqtOKPXrMLXIG7VZosws2aUBZg
         Gva5naGCsDbZB552UsSjXuGROXaen+eZ4jASNbzqRawau29aUbf6nIF8WUvmtfK2iNHf
         LAga+8I1748fxAQ8coM2jPlCLD17KBxIZjUoTyAN9EwG4kvMjcRzHO1nJAMe/BTLRMzR
         leSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2VaatxyhzpML7bs2Vyha9bgofUPxig+IARKsxiGrm3uOxpztR4FpfR3HfMNJqbw/nxsnAMYgqWqP58aSK+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmuthshJ87c97n7pb6xzzt690grB3e3DinXbLAEHx4TWg1zHB
	2A0aRFKOhHahbPxoHmShlKnvPyNghIbTqk9d7FCh+sPtnvUsl4la0glC+jsB65A4oU77y34dfZF
	sk1APoiuqAd6fg7PlGa3Sixm5dIS0uN5JLCrF6p8N91AwV28c2SKrwDfdLT5BvaP6U40CZg==
X-Gm-Gg: AfdE7clTNmIdI26xSw3KvUA8o4/raIAHjOFvflvlyuihJdIVPKFSsfaP0u086eFkr7W
	uoaTEfYcjo/+XskX+R1viUjkcf/je1j4PMi9UJO2sGvrdxZS/3JCwt/qgGFrGrqR1EyOk3LPjdt
	kwOvubR70xgvHyfY2a7l/rYJZexrFswqNKsfZ0gYfyEOuxW6eNzUiIiaCrll/uXtajmmMC5v1rG
	KumyKQnKoSvWmnWG1bE0EJKEjuzT12FLGnYH6qnZQJSnqsKmLmlwMhMVNh++lRpuIgtjz8wPr5e
	VMdOldOIdjz4T4ZZmjZpi760hc/GJemXtnmEAjXino/GKlhmzscookNT8Nvn3mfN4FAa9KhL6XK
	FwhD5e7jbyncHwDPXUAa/RLsS3n8n8LbBJ3DH1mjksu/uYy/fI9u3ikkyQ53gwA==
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541931cf.78.1783595841177;
        Thu, 09 Jul 2026 04:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541381cf.78.1783595840774;
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6cccfdsm54034235e9.1.2026.07.09.04.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Message-ID: <8d15c107-30b1-48df-9e69-a7e8520f4e36@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
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
 <20260707190254.030598804@kernel.org>
 <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vu5sTueynr7gi39NAYIgTXmLeaSxYCad
X-Proofpoint-ORIG-GUID: vu5sTueynr7gi39NAYIgTXmLeaSxYCad
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f8342 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX5xG6AeAEDUsS
 0JHnTdovsJYrfDIbPpuzWZDcXUV0p+oHUALFfBiE1VWVvuUV859H7ildTWUkyGL212kQsgMt1E9
 4ZWskCyQI4v2YO6MVGVXSUpI6TQuwoqmSy6+04nBBD2ZNz+9x8orwbhfl68QWGD/M+ncPNMueL/
 yFFD8d6O7PdeN987C35eqV5cYm2cMDTRgxNmmGzSwGZXdkgMjRbFkDBe7ObpI7uEtRts0sJYCR3
 kVJES8zvDg2NtuqTk/hmhkepDxfG81oV2SnPONo2SsmIv2SBxxXNh+5ypCLp2+j4mZAJY9sCtLm
 W5f/5Tu4itdRh1c4NegpTIWJKXGfBugt1gjZQexZ4ZqUdWmd46/S2Zbq472nzp5InPR+NMSwS7c
 XaAAdQYAFOugYCvsS34vHwkJtPu3XU9+w7V8yXydRSSV4ENT1uEBarDPJgl5y38S39mSHRuuOLm
 Wve16KjYVgN3oSld8sQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXyjJ/7tHrRDXV
 16MHRuCmVFK2KE0ACgZ8T8QB1ODaYMrHGzeBnWHIW/G27Uc0CdDWXYoib7NhCSZHwdb/o7oiBQz
 jMwj9a5BhU+nXsFl3KWBetFzNca5S8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 9/7/26 04:46, Jinjie Ruan wrote:
> 
> 
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
>> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
>> the subsequent invocation of add_random_kstack_offset_irqsoff().
>>
>> As a bonus this avoids the overhead of get/put_cpu_var() in
>> add_random_kstack_offset().
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Sven Schnelle <svens@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/kernel/syscall.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/arch/s390/kernel/syscall.c
>> +++ b/arch/s390/kernel/syscall.c
>> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>>   {
>>   	unsigned long nr;
>>   
>> -	enter_from_user_mode(regs);
>> -	add_random_kstack_offset();
>> +	enter_from_user_mode_randomize_stack(regs);
> 
> The #include <linux/randomize_kstack.h> can be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

