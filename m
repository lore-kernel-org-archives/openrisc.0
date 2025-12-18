Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB704335091
	for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065615; cv=none; b=Qtv2c7X2VV8Gd3nLno9mu5sa9yZYZnwMYTVWEW3keMj3b6oOSkAeXK/7/iNLhAsk3ynPtffVdze4iV4mRctJeLT1UO/NLDu8yyrOOwsMye1S+RzDFUxvmfOZazWh9ANJntsf+DTylMtDHGbI/CnbwdTfyx5o4EKdAz/RuR/1j2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065615; c=relaxed/simple;
	bh=VuldaynjjyHRD7bpmqZ3xraHaSA5Z08jBntaw5BlUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujL/g20uXvvBw5z7tD+fOOVIRHmEBWU7L0jLZ4igySiCRt1A/aNDqlMRwkq3JFRvFFFSiBBoGvV2Q/KWiCwj1ww58jae28ABdUd+/WsZR3JpI+8TuSkTl6fRlhkvytJH5lrK3UDyOWbXCse6CoEzfs1W1Tg0rRny7HHBGFNpZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btVQzLkh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=beZU3Su9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btVQzLkh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="beZU3Su9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI97hkE4147950
	for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 13:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KwlTvvmTQpY42zJFVgSpga2I/ZMAd5tMFKfFhaAZwnc=; b=btVQzLkh3+gM/Idh
	PWaIJjN25pgjQj4UCo9syNcEZljAu1mi1bsB7D7y3U2lGcriZw1hz8mpstGm1hnx
	eZ0rAM9nMlbnScj1/eQitfy1eclYYoz7utAVwsblFGTtyTFaTkLeH39xVXDcVXMk
	mSwmKrQt0OxEk4FBldo6ywpdPdZOkXJFECP2pA95bD0gMsv0CwaGRJ65LZ6hpAXo
	S7dbsoM37HK6j0Z94JO3RVcrW9qdP+vMDpFDRcCHQr8aov4UymjbhBcAAFsOONl5
	RHeKUxdVugj/DtjxbY8cYNhuyJz40DIZYD3D+Tejgkl9G8Fzy/G5D9/c8JhYQIuk
	WQ+52w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u7bbv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 13:46:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b4f267ba01so413698585a.1
        for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 05:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766065612; x=1766670412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwlTvvmTQpY42zJFVgSpga2I/ZMAd5tMFKfFhaAZwnc=;
        b=beZU3Su98Px5ZNWewkN1nj0zgoty6SrzYQ2t0uM+5LwMBWrFeMWpaIUZbU90BvPX7x
         dHXMrtoyt0lsoyFOqHfQQXr6AsemG39VgfYKHU/ii8BqrTu5uSMxLGAnOCfMM411wc9E
         hOlzFTgRxn5yF/z30DeRXnr1HDDzR1zFqtQEjBxtJSakYkYg/igWhuwvL8o5DNmJCH2e
         IxyyU3sXnIoHMNTeY3A3ywDXcGZNCvqnD29pUKQOAD1ka8/rBtNea7ZzPSGSdIpbnmjw
         +Gb9Nk6NbMy5b6H7VGUt8YVF2QUKNLcHcRTIKLPYmhIVHW7W4CcLPQyJQb1YqbF9uFoy
         rk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065612; x=1766670412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwlTvvmTQpY42zJFVgSpga2I/ZMAd5tMFKfFhaAZwnc=;
        b=RkibZ6bENX11AtF3mQbkpKs83hXZd75XM2mPAjG3d3mljJZoS8Zgc9m744rJq8Ec2K
         F/YFZn5Xc8rrMO2Al1Weh3ODyAu1YZjCAzRuBOMYGOFclz7v3CuyPy9KZLaeN461629y
         UoRbjLzxDGoUSHASdz1XGxYF/rDlH4UkTI8XmFXhNoWkI7dKkIiJ1HlQ8j0Yq3862BTG
         c2ot5qH+KMrVcfdBuEz1iiRHpCR1qEHKccj3JtwKiasFXxHIH83KfaEM/c+J2Intvyjm
         ScwpqwyCGK2gVMsQDPXO0O20J0bdSkBqCZYZXKCs7rTPm1GpGrOEXzPVbNAkDKvsU3lZ
         RO1g==
X-Forwarded-Encrypted: i=1; AJvYcCXdLUEQsFgN/14VaWqLfP6VAcxHT3gc8WfR4TPjqDTol5u+5Ytz+0DRNIiuyZnNjjA6gBvRJ4faQi1C2sSGgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytUYfPjzB3+eDDaTTdRXnSk+IghkGqSYrrTXMlsKSdAgxqS16L
	j7+L4ptHtoTcQnDvef/iKznjahX0qKQSABHQnFkJ4gKGD8z6vwop64ZDv2g5hB/ABkTWX/46xgW
	zLtwiYgIdCptiLy3PxqkclobXN6r3ip38lvWB70vXU0FAGixNJ7diqS1ybapL19rAOBq3De3Dd9
	j9cQ==
X-Gm-Gg: AY/fxX50YDzxU56elmpwoDZ8fM+36z6R1ngGUovPGuVVVnZ/uzGwnJ7Cyb+QkkdXEro
	41vciNywrGNfOpvOt66kT+ncheDDbZTenMQyjiH0E8WtyOn+Wvr34Kzy/o1xCeBAF+VQfuIv6uD
	E14/8kxP7fHd5aAT851ZyAqrDLt3Bfv8ZCpxwpZ+P37Bb8X/tsiqhvzb3UnL0SY01NoF0ca2IRY
	7OOOWYZeN5KkvMFdlhQ6mSMENcptPNt9sZQyzbTG5K+3btnzRLpL2MOV6txF06GjugiNnvFExYR
	ighvx0+gojRyS/rcj6naM4eJd20DzQ1HEZqg/t4s1tY7JauuikYNHtgmT7WtJQPUx6JRZibU4Qv
	CNa8Bq6a8/reWDNZAGkVWs4Xj5KJDexU9HD9lxHs=
X-Received: by 2002:ac8:5fc4:0:b0:4f1:8bfd:bdc1 with SMTP id d75a77b69052e-4f35f4849f5mr39158341cf.40.1766065612138;
        Thu, 18 Dec 2025 05:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0aTPFWv6Vur1QLO0VtXXvDFiV5Y7VQlGYzunBEzfX7u1eVKdX0BZ+nNSySGTIQmVn5id/Jg==
X-Received: by 2002:ac8:5fc4:0:b0:4f1:8bfd:bdc1 with SMTP id d75a77b69052e-4f35f4849f5mr39158011cf.40.1766065611672;
        Thu, 18 Dec 2025 05:46:51 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:3fcd:522c:c7f7:20f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be30206fcsm39447645e9.4.2025.12.18.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:46:50 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: LKML <linux-kernel@vger.kernel.org>, Stafford Horne <shorne@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/5] OpenRISC de0 nano single and multicore boards
Date: Thu, 18 Dec 2025 14:46:48 +0100
Message-ID: <176606559331.6520.4498279930581822500.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217080843.70621-1-shorne@gmail.com>
References: <20251217080843.70621-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7pHAnp0L7YRzboS4iy8RsVdiwTPHD8oE
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=694405cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=IJgOUYp38_kS2xEDhEgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 7pHAnp0L7YRzboS4iy8RsVdiwTPHD8oE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDExNCBTYWx0ZWRfX6cWtK9KONyiP
 J/GHKM1O88XiTerTk5sZvJncSj4/clE8f6Lr8Wn/teC0tr5Mnsm7z3ssA9wRqGnDnFDeznvKpFr
 kx/z3OqLo8zTA1FXX8kFvUONxLY/DkjTxwc1Bw0aHn2moe58vQ6b2YFzRUHxWtt5cOdByVwzdMj
 jNBnhXvQfspn6KfVF1uKj5zEbp45xRGIKFnU0H1TX2vHfeRM0dxCCNxr827LNPRNK3VJ6BpGI3z
 UQWU5NC2Jx32QWdw6ZJekaB9IpgrEkyh5FmKowF/x6l8BbP4v68rOLS3ft/CzgUa54miw17Ra0i
 Rrdp+4XaxIyI7IyZiYmMyhrUkvA1uwnDMkhgbHmOETvTBB6xYQQLcoqFTLk9TRFbrljuO6p45Jq
 7EyrgF1k/NommQQXwXgYPir564jOkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180114


On Wed, 17 Dec 2025 08:08:26 +0000, Stafford Horne wrote:
> Since v1:
>  - Use proper schema in gpio-mmio suggsted by Conor Dooley
>  - Remove 0 clock-frequency definitions in dtsi file
> 
> The patches add support for OpenRISC systems running on the De0 Nano FPGA
> development board.  We have two SoCs which are available here:
> 
> [...]

Tweaked the commit message a bit and applied, thanks!

[1/5] dt-bindings: Add compatible string opencores,gpio to gpio-mmio
      commit: f48b5e8bc2e1344f588cc730082aed6ccc5a6b3e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
