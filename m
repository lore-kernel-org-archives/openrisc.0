Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B228F51A;
	Wed,  4 Jun 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040368; cv=fail; b=dk0TsgHbBIgwglShsYFZVTmd4dl4sGmla03emZiEbt/LKnkSGFaqNgocyRtVVpw/erPyRB49ghUYxmybmeay1syohCyJN5xIiHZDuTapLQXkReFbGv89PJiXAOFP2/I5KQ8AdKevGn8afRALB6fP+/pIreo21OIeqmx6/HumF2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040368; c=relaxed/simple;
	bh=2gpClC2EPXwTtmzo1zOTgbCyJrFkGyCkXx17U7Y8Lnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWfMWv/9OzpPVRhMkTac6HoDOfxFRGUOnXe3rfsSPIEPrCOEPLb99gk97EO8tsoyreAXos/PU364/CESpd5I1sd7SxKHaihmJ4Aek3A+LTbTkYrYJrf6g38/pKrt/a01MEn3mIvghNgEQTTCnD4anmQlv2PHutYe4n+bS8twSvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bCs5mJrp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BPMAI6WI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bCs5mJrp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BPMAI6WI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549NdSQ018925;
	Wed, 4 Jun 2025 12:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2gpClC2EPXwTtmzo1z
	OTgbCyJrFkGyCkXx17U7Y8Lnw=; b=bCs5mJrpxuKGKacTXEIwBJkQn6FMCLPsp/
	vPqR5scy1vbVUYaBd2A+2n5e8Z6BCtxIfXh+cWUd1djq7bDrzjX4zgR/uB9mlBeF
	osQeOGINyHz74qxRLpOdEsc3uajp/9qGKcYOoUWv2JNFKI/gboIiVrCvwTzNRH0W
	xq3sNxes7s32j2R0jGYrKsp7rtkkkGpiFKIBcSRa4bxn/G49F3miFqzRV0xioMbR
	gArS2j99s1NsO3QTgcSsmbS0Mg5X9umGfjPDy2LQbL+kE18rRg3S4esRxg2I7uBa
	x1bI1mAWgrNmBwfg79FH+BnFF7915kyzVen24UzoL+RFz1lVVfXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhbr81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 12:32:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554AN9m5030676;
	Wed, 4 Jun 2025 12:32:06 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7apw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 12:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqxWDVDS5aTspreluUccJKkXIf/N3NBgLpRh6OJVU0diJvFfZ53qbxNzpjfYQzbnMIc+KaDIcMXf4rXzS1TwvsEAw5H3+DrUY2j4qzuW7e+az6qYPnACVeOP25dPctqPvw1sciRIy5RhkICFCGAolVajjTlBR/L5D9KczPktxcaEexNbAFyqT3PafLwTVg7jEn54V0r3AJzDDK8oqPcJoLAuAIF5OjJohi9qwiUaFPz/a6+Fe4ih1u48750zkz8mxZdQ+0sxN7QqHcJh0uRFdypG2IBtHUTyEREx4IG1RJzaDhiJpGv66aZMqI/RqEHMVaZBpumRvU3wvOivKyiX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gpClC2EPXwTtmzo1zOTgbCyJrFkGyCkXx17U7Y8Lnw=;
 b=GGShWYv4Jy43SQGiNyrV0kV7gjVusCD7vMSgXam/Vr6RHXXlQnsjgxddD1y1GUgXadmK+A8QDmjp9Zh0jiE3/aK9L18cf3S5UEGMg/GS+DVzqfCAJuagb+rpNYsEE3BINI9yOEArvBC453Tuu6jgaiTNwCoM/sXJuUQjcEGLeiL8j+unVbR/iD0uYLc+0bhRE9RCicCsYho9WBH2m3ZigX5BC/nh0Nkohxkkz4CVozSnR+3BDBlSxDcOlrXjeMzB4D//JBMmRTnHgTh/kEsFhw8CVaIhooKajQje6o6kNMpn8ykV3XDdXIQ44W9FKUURCtQDUoglE6G5Sg2rLBJlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gpClC2EPXwTtmzo1zOTgbCyJrFkGyCkXx17U7Y8Lnw=;
 b=BPMAI6WIBJ8b2onTtron0ImPhhKiY/esrrK6bfvHFLQQjbnLMdEW85oK/KsQudaDUc2PR5xgOr5i8Iwg77VRtnb2Ldg9vq9riK7cUbW8aoBsxEW/WGDirEKXr7guCEH7b8UF45jGgEItyUGgKQBHlEGjaUVUfTxgkChS9AFbqP4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 4 Jun
 2025 12:32:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Wed, 4 Jun 2025
 12:32:01 +0000
Date: Wed, 4 Jun 2025 13:31:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <baohua@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <659ad3c5-138c-473e-81fe-a64772c34e5b@lucifer.local>
References: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
 <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
 <aD_-qdg2OvKQIyRg@kernel.org>
 <d0df9d25-f6c7-46ce-9808-cc92855d6e9d@lucifer.local>
 <aEA7kW-D35lDzN2K@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEA7kW-D35lDzN2K@localhost.localdomain>
X-ClientProxiedBy: LO4P123CA0202.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6767cbef-ccff-4ab3-5ca1-08dda363ce7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwqtNl69D30/KNSICIUSlqnoZ2UWtRV+yfiUuP//uSYsoCxbYzGajssQAgv0?=
 =?us-ascii?Q?60qVPLzfIzmIaofAZVLWBRS0vj6mCpPjRG5TVN0fGHrOqPgo+ebsFzEeQJFg?=
 =?us-ascii?Q?oF64rWTOJbEmfe3DzeGw0LymJv//aqmUu9Nn+dPIr7eTMtIT3hMJW2rJUnqB?=
 =?us-ascii?Q?ZqV80oX/2lz8wOnJsMm1XWlO/lMJvwYU7cPRjm9XAfkU2Lbd4VmsCAw1eZMi?=
 =?us-ascii?Q?o9B2koY8s2qqrV2BF1KCL7Is88hlkS0t+aKFIDIihtbMqswnnjVlAk+L1hOp?=
 =?us-ascii?Q?SQ/nuxONMkfXlB9y6LAKz9hsbafsW7463AFOdZPLe3XeFaI51zkXD/Os6hc5?=
 =?us-ascii?Q?3WwsqI86b3wfSTMwtiFjDcdjBAjkoRqCIFtu+gbrFxp80uFKd0u5SVZEFGPe?=
 =?us-ascii?Q?lrmC7sp/6DRg/cavcLiZGeUuhjHeI98XJzbFRMfryMEk3TULns5KZfOHIujI?=
 =?us-ascii?Q?JqlZrckasp1X72vlqbvTrrUjueRzSLBUeCKFY6w1V8QygcEnOSv3+cvDa6Xq?=
 =?us-ascii?Q?xi62H9rDsjFoGuoXtu5MFvtV4gyPaPXuBfcK3jSovxhV4PMCluLGfevsh4/t?=
 =?us-ascii?Q?Xy50Q+Z/x9bx6iyXR7RokCxTAZ9hZeUKDDopnnVgXE97mP71OQ8nkddtnmV0?=
 =?us-ascii?Q?lcbG0xhqUlnCn4kJx42BYNdjoF7XiDEFADXpHgFXjN9X2gw4yQtm/GH/D4AB?=
 =?us-ascii?Q?5JaXI2PbgEKz4ku0usapEplRHt/5vN6qQFJMMWjZ5olUcn/35p2aiF1HVaAp?=
 =?us-ascii?Q?wE2cesZZrDacwBkkdWbJ1YZZvPNH4sj6RRbdCxsBWmKZfTmttuuBVzMT8JhJ?=
 =?us-ascii?Q?anuddItgYc5JTEex7+zFI9iLNfhQfoIHG/zJQo1tDKcveUU+KpdRSqwMBgR2?=
 =?us-ascii?Q?XgQM5j5QqxHpuuudJn4sBw9S+39xLIlA0uXJ37CiyVjacBDs9/gK2p3Fica9?=
 =?us-ascii?Q?PzDULjodJHPpCz/J2jHfkKyv8/tboBkzSEw4joA/RXm1EUqkqejkHoeNNxu6?=
 =?us-ascii?Q?9g9pOEK+gJZdc2FImMeYnW8iAUrgCCWV1siIwaTBjIMRVGIaBR4sctPAoxID?=
 =?us-ascii?Q?6l5XyKEqvd6soWuae5fd2L1uyXy9ebcVk5zQLnIkrySxInoZ3MF+LsAU91yy?=
 =?us-ascii?Q?BbMrSqFzNQyS9AIoll+LD5wSl4tM3KQCDLGZNogpzKTyNUGdaL64YLGQfo4z?=
 =?us-ascii?Q?vtJBR1IU04hrmf0k59uLEQpWb8PL8hOncueNZst7sQzGchBY5uOgAAYvB5uQ?=
 =?us-ascii?Q?TkaNnDebA+fBVAM5oxhN6EjaJLWdx3/wP2dINIHNXqrfGdr9JtfOCTr1P9Rv?=
 =?us-ascii?Q?l/EqnHnomkqLa8mApm6Rm9OFPyO+0tcEE3fvtULKVFec1E/6f122kjPD4fZv?=
 =?us-ascii?Q?RIGTfclWaYO5wDJJabPCdDxk4nfLDtCkILJ6b+smLrPDUC75Hhjw/imBPxDg?=
 =?us-ascii?Q?R+aLYJp+BBE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mODAkP04t0jmrpqLNvWnXnF6GJ7GcdLnma7/8J3WXmO9WLXsWeQxH0iGY48K?=
 =?us-ascii?Q?+aWlLDYfmrQL1Yb3BxYoJV6qLw9YCe6QzfDoNidRfUv2ZBgc/+BBWSJW7AmZ?=
 =?us-ascii?Q?nSjvNyd9BX9RjpCICIKSdn7koP8Z8yPbsB3fwhn2lPRFmbegWoLxxRTqGK4W?=
 =?us-ascii?Q?a266OVv82XFNhmyqAEAgwwsSd5xrvT46ETEXFd+J9klQJBWHt27aon4XOX82?=
 =?us-ascii?Q?q0YX1fPQAvJ1oBHLGhNb0vVwtAnIFOXZnk5XDtJ3umQnPUdjexb+6OgA2NGY?=
 =?us-ascii?Q?wCEs137QkNZFyXLgtDfuTfOBO1MixZZmk7seJZ7PUz6mMXD63SzYwzKPh5yb?=
 =?us-ascii?Q?l8E+YnHJCmu0/85Rw7Q+6KNqYA1h+vjEZ7/gLj/YqrK9/HvJuR9aZSDpeVvS?=
 =?us-ascii?Q?mlMiQyXrMQjc2CjeqIkKUSvwZ6N37LgFDLxh/OrDsobRpSZzOia8yjplz+N9?=
 =?us-ascii?Q?wjqNPflwGdoRYJ9c9b6ItX3FGE+B1ncOQV5Dj0zmzzcGDoiXLL2U4diyTzrs?=
 =?us-ascii?Q?TCyMRHDxIPRdbzviHifibrUcdcYVtGqUYw0aBkz0odTn6lhsp+OnojwW7Lcx?=
 =?us-ascii?Q?brgTZid1UVY8XAAEPB90lLHx3tBLtazRwzmmHQUbj7KChY1kOxBNZ+ffOFyU?=
 =?us-ascii?Q?whvrL7R02XWBWvcba6H14b4N+vQtEf1wiyjf7rOxT/fz+DLEYgMmRgeqCXnR?=
 =?us-ascii?Q?EulUmQKS0/JU+vMGEljaeIWEqU7/pZyhp/LCBQ0FpEp3NIGC+OXgTr2PL5YA?=
 =?us-ascii?Q?YrGqCmdeDprC/Zry55CO427SmpOlhu8bW21MENCH4oQ+e+LRjvkd+vv7vG/C?=
 =?us-ascii?Q?YSb9jkBAYldTCpPyaWCQq3txwaWSXgW8igG2ek/u2ZUpu9VSJ8vBa3wo8JlT?=
 =?us-ascii?Q?piXWVdidHx1q2gigU5V9/sn0LlkhJWi4ynC3vQ5I+6XoPKlIUQT0z/3bZGPf?=
 =?us-ascii?Q?yHHF/7lxBBHYGZ+kdCWwWSguYP1NB38IzTOvAUjL/i0E25Z+psPIGy0+Lh3B?=
 =?us-ascii?Q?vJTTSLmMx0GVuzlXAX1hWmq6KOR7YCQV/ATZe6WevyDVqIcJQVnzDg94/DkV?=
 =?us-ascii?Q?BDiGLqDW2Vy4F+9l2zmGd7HXzi0MeaCVCyabCHAIQKWlzrwCH8w9aRT0vREb?=
 =?us-ascii?Q?a6rhj6baiV6CpPpt9z9AkfY7+AkOFvpvK7NLrhYp3iDSsj65hEtCZTeLJWym?=
 =?us-ascii?Q?mIvaJemeFhQgeIihiXlT1pMg460B7z1hfKo7PC1nSpHtrGZT4DI77b+MDCcO?=
 =?us-ascii?Q?GGYyY2sIfXfUzted3dySQ3dDeBmdvA3SVWI3R9n9oZSm05polsOVR+dDt1In?=
 =?us-ascii?Q?n5sfQRiiRBcqvQPTPKle3ontFLC+Yt80pPay6co5xgFfhl/2aYVoTS/rp+Fw?=
 =?us-ascii?Q?urSbipfnFG/WzZGHFM5AxqKRdEySFQzHb4+Ti1Wm0SPzoeMqDGdVGjNbjTao?=
 =?us-ascii?Q?Vh6/933GhKZgXKuq/lbb0yXmTyxU0wbGmINl8laIrJ7TevE4H0tqSfQoBjj9?=
 =?us-ascii?Q?z+6Ero2VOfHFpTmhOerv7BtXMYWlmpD3onGIq6XQdWDW2CmSuey1bU4djfdL?=
 =?us-ascii?Q?cXpvukgDQ1KTLM2O7/5HcTOFr0+fYkR+Ejj9sRH95K7d6XbAaQ9wvUHz4yY5?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sHrCzEH3nniGx/kScwhLCRB5hGIJC2y2Rem4X9OGywtoB3zkeCfqH6K2YPcuONXUglSuimfHAfKBi08sv0+rLBCRs2ojqdQSwC6ugDCJ7DOaBbf/fhA5Bx6CcTJIbdUAG5XCAtE7C2tOoeYjgmMmz9lNjwWJXLr4ig/TzcQKtjqJ7/5Te0SeHTRXM0nRJGGnsmLo8dTvSqhkOa4YsFAGKKvGpzeP+C7UiLHweS7JxXmA+aFL2JdZQUaJDu/ASREcT56tSl8WxQG8xhU9fWABdDrwvawLYCDHf41mYQW7jmbaCeOMdCURNvEGrKsEAbBn+LRKWRsJ+JaaKyZV5x9neh5r7oOEfjK5APp8wnmZ8WYx5entUwmHonmpGqfI4e2iM0PhlsHDWOXmLLtnFax57hZT+t8oaDYLCggnvjdCEsyL7j0sqDqNwH9waQJO+0dqd0NhoZ3g8JWJGP5eK63I6CucI8fPhk24Be8j+6I7LK8q6lDAwUP0cg9UxL/sz6d4mBUtePXDZweCqE62r1ESX4ER+sT4nktRYlti0edrAML1fC3kuHY5e1jPzau0oYRci9JKs4qD9fcBBbJXO6AfDV6VFY/CZN1R3TzS+vULQlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6767cbef-ccff-4ab3-5ca1-08dda363ce7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:32:01.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgSS4NZIIvxtw2LB5X0TGXZUflKacemOC6y6vMPm7RBiMbcSYvgsPr8OKR7IY/e7siM/XoC6aM8GQ1OlTmJ8sM8Rcl6ORy+f3K5Vz4wEdAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040094
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=68403cc7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=olpZHVVchgdMGqTVwmkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: M17ffWvFjMMZY1PWV2sSsLBGj8u2UHNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA5NCBTYWx0ZWRfX/ReMgFlEIKlr O6jiOSj4NnIiTdrchLSSClX/Aeeoys3093Sy/Dd32MjR/v30t8dBi8fv3CrZH5idplBWjVbBHwI fI5eOtDgx0JKWiS4A8O5KYZlak7LZCbJARDK2mq73KzX0sbOaGiOtq9yoGBz0OSFLkGef3N0l8a
 knBjrEbjVB7pENTAFUiyD1/x0VHOIPY/BB9TahviWpr9jHlUVTtJG55EN+tpqH9g5mjLs1c89JW x6uvMDBgPfz0AjkNx0Y/hiIKyMLcyrHCWbBzoEm+mNhlZoCDUitfdPcPQfjnACZkaf1n7YSKd2J 30rgO+rvZSmaKQHIZyCHmmZp/cXCoUHKW99oFfx/8tcq3kzIgrIwqAgnWVAtWX34QTe/8aIxFfU
 2I0aywnzizAsTFd9kLuuVzBdA42xxCoXZxjLlvk/MJq9FUVcCZXEq+SjgyLY+eB9ThNPBQxg
X-Proofpoint-ORIG-GUID: M17ffWvFjMMZY1PWV2sSsLBGj8u2UHNP

On Wed, Jun 04, 2025 at 02:26:57PM +0200, Oscar Salvador wrote:
> On Wed, Jun 04, 2025 at 10:09:05AM +0100, Lorenzo Stoakes wrote:
> > Nice idea to move to mm/internal.h also :) I like this...
> >
> > Will fixup on respin
>
> Dumb question but IIUC, walk_page_range_novma() will only be used by
> ptdump from now on, so why not stick it into mm/ptdump.c, which is where
> the only user of it lives?

There's no such thing as a dumb question :) Even though I have maybe tested
that concept in the past personally ;)

I think mm/internal.h is fine, would be weird to have the declaration in
mm/ptdump.c but implemented elsewhere and obviously we need to keep the
page walking stuff together.

So I think it is best to keep it in internal.h

>
> --
> Oscar Salvador
> SUSE Labs
