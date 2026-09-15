Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A14756CE
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510894; cv=pass; b=frAvUQw5N7QUJEXH0MgZvjkd9LEhz2PIvKrLMHCGC0n4hPgjUdodYJK0f37YpvSK3oXFaurGqxVHz7TCzoWOdTrQTFSNwjIBlDvJbbbdn0/GSN84zh34UH5uWxXptRShfAQ6GmBkfOCrJpe1A2K8vPIYEN6+ev1RIsGAm3nhm5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510894; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRjEY6GhYqeNtkIuoHAh48h39NdOEHEWD5TdcUWEB6SQs6iGQnyKRjJCkX2jC8ey/BZ2DUVNZdPfq+KfSHDyWbxcncMsv2XSZn+xs2IMlKdEOlZqJM+GuHbrjdt0QfvJmNDRisrzhm0bDexRKKyiEGE6rLJ1tYiJQtUfNk9YGso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ8pX980292
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtunvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45e83fd0663so6244513fac.1
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=pYILkXMg/777QUN0xH9EY4CsGALaDblkfgTCsHBXhY9HZXktD1hu2NGy4M3WgOd4Du
         88hOIVG1iTguK3+zwgjyvunh+MNehHgjZb+LWZt1UJ5N+A/buuhxYCNkOF29ZsDjkDcS
         F72kgvCTkitvm1q1WvclFg/xni7i9TPUBrnsxqyLV//adzuhK5RPUy2ASZPXMa4qNDy7
         19+wLqs6bTtKgCfbIHb4tncuumN6PgIFfyenGDwHAxumKRLW6ySvC3g8h2XD+7UXVLii
         c/zncn8O0ilQ6859i8KI+qaF+583C+PWOev87J+qdFNZRJW/FBNsgFuPvrGsvtdID71G
         sMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=dInVty43riqLve1g94KbOomlUmIIh4kxLSUdfYJn6/U=;
        b=EuJT+joEcbh3p2vHQa4AMu/9J4rb9njDcSbHGJevM8uWde5FovVug56bUxSCkBrZfz
         cYHEM4nF3diS78FWgpEIazERbdUCBsGUxcsQjT0nHCFO5g9rpMypeyPZTARH3qeW8Rxw
         dqc9W2zddfIgfyhIUP5H0iXPJUwx52FYKOrZbFKksg1845JFUNfTKio9pgL3aZLdE4oM
         uzXsz1StZzGvAcWPaAt2tkCWye+2LFnoQlr5UF3WhcTtyNrAd2wn+xpkEXD7GHa2fUMw
         jNtLThlIttz+039UWVDwv1CJjP1iF7vXPNiwtqZGRJiKuCvjtk3KeC+zFBfprkKfrPsV
         rFjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=YKjul8sx58+7VLWvqHJUS/Al8nR1S2BrcNr4AH0gSslC5Qk+2x9TpVHce1O2LJFgMB
         4QvlgL00U1SlCVh2SRF0nPg+q2lha+45ieoosMcPXenA47h5cJ/H9JPTsJ7WrHyJvx+Z
         +TRjcmo5CopsaPwLPX2Asaon12evDukGCqw0vXbazvnCE5rtdPhORk1sstjX2tt4n0lE
         T6LARoBGS7NY07WHBw8E/5/wRZ/t94YYqZwwxbBMX69Nd/eKCwqlyaKBP9LTGMPl2dTO
         7Ift6Kpi4lcJ6rKsfnATDIL7O4tzYXFiktn3/CRp9VHgHj8pY+eyDdp5BITvcRH4MtuM
         BMLw==
X-Forwarded-Encrypted: i=1; AKwUvByS3q7ZNHIrAShTanGoRmnCJ4lN8beUmE2IudhamkI5HU1etBkhEiTAV2KHrfT9iaFVOAaNv3hinEPjIW60cg==@vger.kernel.org
X-Gm-Message-State: AFuF++kmwAGRZqqUUHeSGiSxndSyXCzpOjo0YSLrTeD9G1CNW716V8Cx
	T5rYNdUMcwClVswzOyWs9wdsubR7Gp3SobMyJ4CsmLGXjDG8gtz5vV3zLdOehYxSXGMfOwhG/ZB
	nQU1rmeja0bPyw6ZrzrWtapcuO91LqtZkBaN5GoA+IHbYk+NirnPapNwRKV8RJyZCG9XmkisF5w
	OUwZLLi258y4mmrnzDAD/wioyRrLdLAvfbMa3Cs4GFfJlK
X-Gm-Gg: AYBFou0yyT9Tvy3c7pY2Ri9B8Vl3S2GV4XY3rFE4WdkIFc4PjzqdUW2yKdbiZFK9jGa
	DylguBPzsHoGTht29MAAM0hN4VRcjnuuJEQudmTb/XyUd1p7oSHHuj/HdQHvK5g2uD2zEe/2YaG
	XfYrKbVKUCn8/BojSPIH5WOqyA4H/WQyGfAAFi71YglkInlQbxC3Aj/Sx9
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189769fac.2.1789510890859;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: _RXiECBvy8arRN503zsqDk_Ebxomw773
X-Proofpoint-GUID: _RXiECBvy8arRN503zsqDk_Ebxomw773
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX2OsKtJ/wYdIB
 rJcQD4B5EH0R7MLVh0s9neFbHfiDEIzqWqg1m2e4IJQSSLHt00AfBW2Nbc1iSxVouRhRih0Orbj
 gUPo/yYaCc1jncoj28v64q+oedZo0Sg=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXyak/XmgyfGpH
 N5wdhVFhcCxKYGAxhZ8KzDRO+Bf1tQMXx6QMAA8FdhMM8/3APQ6vgEIYhkkS8fOwR8ZryA7ZT81
 Se4QI0ipbMbyRmE8QTMHZLASpdk6mH71riZTIRgsB+SVL0g5mFouWwaOzqI5W4wqBoIcqAMhFVn
 ZCQiCU42O1mEJgR68iDuNV1KmXm9BC7TdD+sDXx4ADz+2LMZx0xPhkSxbsIcajygS54oysqByi2
 ip8vyx/PiIEqI80IlA8lwhExzTx5Ez12B0rbalMJ2WBSYhK0ZHVTM23RfkwknTX5omRqCgQ0v/9
 giGTOoVCXZ4yCahlmO4LGJAFB6u8BT5u9oxhLrpR8T1BHCxvpHEzw+5r6y3lCeRHCek5zzScS2q
 No01c1HAl0ok/vgKnaUTbMBGk/PcGB7ihVadaSjVJTGJu4fMp6wWta6JJrspba/lfUbnsewoXnw
 +hl7v75HMF6GfFb7Gog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
