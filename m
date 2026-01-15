Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B634575A
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491668; cv=none; b=Zjj2kSek+P4jCy629+gN55wVKY593TLGx2780E3qloqS8PNfAjYk1qi3pycMjw4RYGRGQbDWucOEOqleZ5L88OsrvIUthYhd9kCOiKViKAptjj7R3kMAPC0BJvCsZ1jU8hb022JvAJDcWfo2G/bzJIdpHe5JwV3tlfl2pNuwBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491668; c=relaxed/simple;
	bh=PVbD3JY/+2fLVRJDBALFlJGzI7Wuj6b5NRYNnDAixn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxrGo3BADTnWXJ+/aNj9ENIFER3lgkhy3bDBKANYm3LEjcXHr5okJGH0veb0S90RBB8mIogipSjnghO4GUltgBsWCiDLNArZUt4R30BGweRr9VH14hv7+GEFS/DBKQLxvEHZIFsfpTiNSJBSltZEGi9LivsVL/S+fFYts99VnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UfxJn74g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMb13m7v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UfxJn74g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMb13m7v"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FFYIAd1722756
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Jn8t5yJvZEuQyGDiKMOAfso4NUXVWf25vNU7V3mPF0=; b=UfxJn74g+jH8bGD2
	3QJ6+kcaJsbSgH1oIRykFba4y9xAm0/3DzNZukuWkaaVprLqk5u5gSZrXVt8efQk
	M9YLD1UPB4/Wtc+JD5Vv0NVHGD6H8Hn7O/BURVmBjfln1QOaWrOqNT2YppUI4xgh
	AvDr6u8Hh9aYvFDCimO+fRh5hlEEXY4hCIuSPEtu+Femw0nnstvYludd5DCL6+sw
	nTLD9EZSo+BlV/iX6o+ObbE/6qXxR1nxskU/2FB23ytGrJIVchVj72cglPMsxvfc
	WXgSlQrz/H7UMbmg+/eJ6pI9vCnuc2Kf0bFj73LDWl6Wufp6BAWEANbmoqkQtDEY
	vQPh0g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bptna1h27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:40:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a4c50fe5so88066085a.3
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768491657; x=1769096457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jn8t5yJvZEuQyGDiKMOAfso4NUXVWf25vNU7V3mPF0=;
        b=iMb13m7vvAUyGNJtkKYFogQRLlDxJ/7Yx3LvV6kIdHo3BpHY25KwTK24C55ULxL53I
         nNAqV625/S1+WMszyUIyCe4GEaNoIqUVdms5Osgs3Lur+6qV1OZ5RJSZsSi7tjJeovtb
         TgNfiFZToTbLJiJoo/nrMZ42Eu8Oq4YRR0eKfq1zPhXGCv4f/NOghqjRZvWMUmmGCmL6
         lKYKpvXGCVvWTnX2r4BOOaMmZnjl5sG6foUqwWy42xAqry9IGTDBTz3TJHDXD3cpTHrt
         fu6lJbhybcIqbxsRdfbrAht9pfCqbJNk5pFDsvC5Cfdpcxsr17nje/K5rNv2F7UB5q5k
         HWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491657; x=1769096457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Jn8t5yJvZEuQyGDiKMOAfso4NUXVWf25vNU7V3mPF0=;
        b=T3m4D9dLL86vb8EhdUfZ7fbmQjnVYUE0WMA5ZrpvbkTikdltRSqm1I1GSrgEKMzBVQ
         mEqGZ9VekP0OGlgQ/iQKDE1tif/SMoyk0arHlBEVFeShqG32ZtRMnDe7ove/6M10cOy/
         M7haZsj0+PzwLv+x2De2fB6Piz57N0hAPE8tl621ADEIlJMmv+QFwhsIlhImKhrMK3z5
         pRmFcz0tum0FqKWIKLssQeKc4ZrfdvfrFf5yqBTuLImBabiKCm4qbB0MfNaT5JD6XhVh
         +VhGmi9IghX1ZGt062z/8406yj9l+YRSFZlJHHbpkShQ4Js4JRBLCaHlFWJ01AbtgC5o
         04qg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ntvmIYFcX/40/qgbPvG0CcUJTR4kMaolWgn3ce3wYnDHut7435KVUsR5j2s0udwTHh1ku+PPs7Mf0AFXRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU+zkkkHIroX7oJ77JyY37CsgJzWPr+T7lg0zeso3ij2cfv0S
	JHy6/3ys5vCvBuYxXiU2+GsRfDso+1BAWjYv/LMWX2Wt3vYzHkK1wjxXbETOGwC1gBtL7aIKira
	dDj5HNwkHRc/7OLPWH5pd7PDriltwcrsCoM+e5zyEq2OIKpXcsj3FjwP5LSrFCIrXYKehiA==
X-Gm-Gg: AY/fxX4BGwPf6E70qHG1S1ZwPkB2VAPQQfeH93xzXFvtYyJKFARdzrfmElAJ/juy/am
	IRQnQ3ljnjb3NptpEkZKj4tZLFGBPYlg9ZYYRrFYkA+ebtuz3zj2XeYFLvq5g2l6FzRt7xeB1EY
	oi8nd45EmP+ljw+XBZwbqOZIAWdzx+Ujv3uvKnXyO0B2pxJzFTfM5FFopxi6bjkZJRXVxOKj5Wg
	Yk42gowtia6+UDhKtLEMo8Zhp/o/MtwINto9RNyYFU9MDRhxcKJ70u0lPnkgk3Xl+8S3L3ALsTD
	pTNhHdQdlItJmsXweJLBrm2VX/D4o2V+9mmz4B5PhaSUrKR9DGQ5nTQill3LS29XE/ndKstA5Qf
	/lkZqq0Fbu3DvIqpj5aY5Hr6Wjq6cDYjh/3N0PQ==
X-Received: by 2002:a05:620a:2698:b0:8b2:6251:64f9 with SMTP id af79cd13be357-8c52fbe240cmr896664985a.58.1768491656739;
        Thu, 15 Jan 2026 07:40:56 -0800 (PST)
X-Received: by 2002:a05:620a:2698:b0:8b2:6251:64f9 with SMTP id af79cd13be357-8c52fbe240cmr896660685a.58.1768491656219;
        Thu, 15 Jan 2026 07:40:56 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:953a:ee90:691e:977d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b26764fsm52959475e9.12.2026.01.15.07.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:40:55 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: LKML <linux-kernel@vger.kernel.org>, Stafford Horne <shorne@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH v6 0/6] OpenRISC de0 nano single and multicore boards
Date: Thu, 15 Jan 2026 16:40:53 +0100
Message-ID: <176849165027.29734.708711779514578942.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115151014.3956805-1-shorne@gmail.com>
References: <20260115151014.3956805-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DDEks3E7eKpEv1rBx3OE2cdqCMBIDCdF
X-Proofpoint-ORIG-GUID: DDEks3E7eKpEv1rBx3OE2cdqCMBIDCdF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDExNyBTYWx0ZWRfXz8UsNmMvljbt
 VFnyDUVQZK1fWb3rLGiDsAfO5PJLUBXuBZhDq+HhjnCe+9E8+D+SapAcFNBuu0hf+dcsEEXVUBn
 PU3Gl0I6Zv8VKuuQ12QnxxlrEpIe7n7gLalU+CwMVB37hbkustLtMz3OYeKuw/eCz36AL7uKdBU
 /Rz7srgjuwZ/SeQXFz4p5aAeiBWYbM04fOPc0HdU98MUxjiygIUB8pwerDh00Fwor+MXSWo+y99
 o5RDWIxiPeaewr6qLp2Tt5nTivmPZsMCeSWvpMYNJN3ZoV8EzLzLChxpQWlxg8DAmKD8YAiJirJ
 ofaVHF3OQVqo7wZrXlIhiRIdI1MnAWzXzSIroIA1Ur9pXRmnmigkga2sOrmTojDiM0rbzjs1Z9G
 Njy779zC9/XRtnDds4L0E+zQsdO/IVD0a5hZMCOSYcTqY8XIE+fNVzdSIs2MbpdJP5cqy39CeRY
 /P1jYhupKWsMDlnPwxQ==
X-Authority-Analysis: v=2.4 cv=fsHRpV4f c=1 sm=1 tr=0 ts=69690a89 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OH7h5zJ7Ze-Sh0Qh2Y4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150117


On Thu, 15 Jan 2026 15:09:56 +0000, Stafford Horne wrote:
> Since v5:
>  - Adjust dt-binding patch based on suggestions from Geert and Krzysztof.
>  - Add reviewed-by's on the dt-binding patch.
> Since v4:
>  - Rebased the series on linux-next to allow patches to be incremental.
>  - Rewrote the dt-bindings patch as an incremental patch, Due to this I
>    dropped reviewed-by's.
>  - Added acked-by to the IPI fix patch.
> Since v3:
>  - Switch order of gpio-mmio driver and bindings patches to patch binding
>    first before driver.  Suggested by Krzysztof.
>  - Removed example form binding suggested by Krzysztof.
>  - Added Reviewed-by's from Geert and Linus W.
> Since v2:
>  - Fixup (replace) gpio-mmio patch to update driver compatible list and just add
>    opencores,gpio to mmio-gpio bindings.  Discussed with Geert and Linus W
>    because the 8-bit opencores,gpio is not the same as the 32-bit broadcom
>    chip. [1].
>  - Update new device trees to use proper ordering, remove debug options, remove
>    unneeded "status" properties.  Suggested by Geert.
> Since v1:
>  - Use proper schema in gpio-mmio suggsted by Conor Dooley
>  - Remove 0 clock-frequency definitions in dtsi file
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
      commit: b2b8d247ad8ee1abe860598cae70e2dbe8a09128
[2/6] gpio: mmio: Add compatible for opencores GPIO
      commit: 3a6a36a3fc4e18e202eaf6c258553b5a17b91677

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
