Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213312C3242;
	Thu,  5 Jun 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117434; cv=fail; b=RNSK/bC5V94hSTT4nCtTIkDSvIex0BgX9YgbKLOf7jkHy6IvePqgLJiEunU8mjDOOT3zDUVNJ1fjTjLnFMpl0yPEgrPCBrm4EdIpPb2jdyTLoqnGxsYYSdxIrlMH9ivR2lbeS+fmaz3imn9tR4iswscakEvazbBDyMzsPJicJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117434; c=relaxed/simple;
	bh=m+6dMlDVsDJfBmuz93EV0d8oqIIYQBjHvmrF82vksG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQKrY3VD6WO1RFck+7lfzfhO34z9Jd+e7KyjvRMVydBns7/j6L5pb9gChEMbhySDYxhYHE3Rk689++mlZH/dPlgrKQJBGItCdQmmn+tNNAi+fEOxXpzBYH5+SnK7kqnOXwRDmY5vyZN76kt1WCdKA4OxgfeWHg0/OjkmYOQTwhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q3cXFkfA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pawhDd7O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q3cXFkfA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pawhDd7O"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5554vAgI006644;
	Thu, 5 Jun 2025 09:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ew5eGQl3+NEWrCNkjg
	7/04hFoIGUGJBASh5t/AM4ago=; b=q3cXFkfAXBf3UQSJxyB81sAcf0VsF7cJr3
	gjqILXzL43EiNl8D9DcxAqha9YKd8qM4mMC3vfmW6W1MZpPR7nt9WJkfnYqdJMqF
	VpD5ZSdsStvPBDLmufSEzohfpD0/fN2+/K61fqF6nl1YBoUTAa2LitRCI0q5ZR7E
	tpRfCCd9k3z2txUy9HzswWx9OmX8zt8ybaVu18NUVOpzdH7o+QCAEb9VKY/vI9oP
	M/Kn6YuWghOgM4hymLT0jhHMvCPfReOvKCWxck9DWtNs3azGHmo8xVZKXFb9h9yG
	uyVdcRXK7XhNTKZrBx3VJngsfTJjv6R6GeUWCZwVKpIOfYByW9dA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bnskf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:56:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5557qQdA040624;
	Thu, 5 Jun 2025 09:56:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c42kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2Buxfu805lq/lmkpjXd2PBhdCYjPflwEi5EnXa7ayBK7/FY/7lC+hJtDq5qXM5bUH3V2PurktW1CS3EH11AVSyvQyit7XLyE/73iaP9hKR2LDgd2/yzt0BvV11t36/aKMhQcYcM+ADbP8Kla2rOUAbwxNhvFjpzKVM+O+AM0X07O6F/LG2GWK8g3NeaMgjKE5npo+oLo+iQ4M7tiADZWXCyz0Ba02TSXGoDzilbYoCEPyrX1e1iyCT1zyxKA13L2hke9SRvXcUPPi/p+mGOf/5/mhv7i5969jqKxGmZ5fl6NAQ+p0zRrwqtSM4ldSXqMw8DujneyP4EPmzaAC9Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew5eGQl3+NEWrCNkjg7/04hFoIGUGJBASh5t/AM4ago=;
 b=Fy3KtwZZdOgSYwYefkiLY6HcXBFvIut2cE6LU/ojFpgrPVoVwIdfAzr3yyWUCC9SRED4AP3bqCpMLLPVC3pWJquXa1arivxaJdB+cwYF1NoySEUJsXBxwb9/hNN+CXRW6ZtEYex2q/otlu0D41HmOkPpjWaDwRWotkxlQN0OINysgW4fpg5kUy/Bw/6TnRzdKnvj6jTxDmKxwt/5lkbKjc4HI1UkQQaTMBmpgCbm+PyXBo5iMK3L+v7Wy7GlBcGGjjMLtSmjwFTVqQr80m90zV/S9gVykQWcQPS1ZP8SRcaaDC9Tw7YXy397t4iAbNoox6IqSUtEj/ECrGC9bDtVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew5eGQl3+NEWrCNkjg7/04hFoIGUGJBASh5t/AM4ago=;
 b=pawhDd7OreC6S0EJip6Yw4dYXsIsTbNAH+XASJrAZfJxLty/WVAIs6Jnc49XfzUdR1t9r+CEyxi9jh/nP+13zxxaWxjKxaGbTfutDPndJK5DFqrgtCJ0QTo4oD8rdyUWdtKUQFq3PdL8sCXShMN0Jw1y+929SZeAOQsxSJxhXdc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7988.namprd10.prod.outlook.com (2603:10b6:610:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 09:56:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 09:56:26 +0000
Date: Thu, 5 Jun 2025 10:56:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
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
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <13b573c3-c432-43f5-b687-deb3f72cdce0@lucifer.local>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
 <536f5ffd-b4cf-4f35-970c-ad3a7593af2f@suse.cz>
 <5a06f383-7d01-4ea7-a010-013063770240@lucifer.local>
 <1AA4A4B3-AEBE-484A-8EE2-35A15035E748@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1AA4A4B3-AEBE-484A-8EE2-35A15035E748@linux.dev>
X-ClientProxiedBy: LO2P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ac7b2d-763b-4f15-77a9-08dda4173c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vpkVW4MSy5XUBHv5SEeGteRHTlaGudmAibU+i7owWuI7NN/7aLiyOIGDB9l?=
 =?us-ascii?Q?s62d9iKPhhPmb/KaiR95tIllaL0H67UkRaujbEHmIFlneGl9qCUxZkPyBZBJ?=
 =?us-ascii?Q?0NhIGUC+6aM8FThuNibc9Em4sIRodQ2R30cswy9LUyCxA6WXNSjlzSCyPcvK?=
 =?us-ascii?Q?5qQ1mvlDgNXMnfAamgOzxdtmf/Ib5hFuwotQ4kHuF+vWQ8gfM7vmipYRdlg7?=
 =?us-ascii?Q?p0kfYV//FRdQ3X9zYbjFDZ5HSNT64wCjewmrxq7ykXEC2p0FfYRh2uDleOUd?=
 =?us-ascii?Q?vWg5z7VyGhUtd9YtvvvgwQbp1W8YVc4qrEkatZKwN1P5K8ctn2vnX5yDx7xd?=
 =?us-ascii?Q?Eeem6ZntyTy1D8mUwNxEv7J1VRWlPxdmzLs/l6+hz/GAAB/SyV6tG1kvZFkz?=
 =?us-ascii?Q?k/R7SMFbyTeF3N1XKx8e9oFmQqa3RCOO7gp9S0VcLx76SAicslAl9CHsT3bF?=
 =?us-ascii?Q?AEFkS/eIFdD/5GwthAOAn5Tv+Gzfe9jTdXWkbd5AF/pY63d1/Ny/HKUnXgMB?=
 =?us-ascii?Q?PBEfenU1Ya2wP+3GmHjWqh16Wpne/Pl3DF5MgOl6riUNEyF+N7CyQ/5yyJy5?=
 =?us-ascii?Q?yOQRvchR3NtrUr+1/LB5uLnTcYdQH1eBfKJiTMGIDACg0PaaspZL9kaV/oT+?=
 =?us-ascii?Q?ehtQ/zqtjyi4JNuhojbkhGlLHEdFpa0YdzzB54qnZSUHLm0+tMqY/L7TwWtW?=
 =?us-ascii?Q?o+Egt9dbsVeQ3T6+CgK8Y2FRreCdbG2nwOSgMNlP/OobvDi2wVgmgqb46Gxc?=
 =?us-ascii?Q?7dSn7q2j5YqE1qkil5rPwlA4sV567KRPt5GDumRgx6umMoLq656d4FD3pSrA?=
 =?us-ascii?Q?TxxgdsQZlBOQrqp1bhbq9k5Rorzei9XmLzk+F874vWw9FYSoh+J/ulMT+21w?=
 =?us-ascii?Q?aLFDAJARmRcHEkBfvQxFmDpvTg3YwHRRyTkV1daNdXNHTH9X1xaAUX8GUwRy?=
 =?us-ascii?Q?XEMTJ80QsN6aWkPAihYEVfLzImOHhxRciIQC7WaxVH4gZByFKAXji5UJuTi2?=
 =?us-ascii?Q?rndnYucBOwOtxwQeUzGSXj07IUDPB5u8Hq+0fFFL0WwhvYDgH87klQa2Pb5Y?=
 =?us-ascii?Q?6NVg3Lm+Uqnt+ajOXcAL1cJUByH8C6YCwzE6lEYhO2DqYA2KTM5hr65HMwhP?=
 =?us-ascii?Q?PHQ9LdENOntL8p6/yX/IgQvNK94aH/mTeDkZXWzuaKqYFZspqgNuAD28XmS6?=
 =?us-ascii?Q?MfsvZSK4v3D4P2UEQUGr5XJMKKdm9QWhnwpU9oJ6FmyQ4cN0eTyUcbGqHIlX?=
 =?us-ascii?Q?DtRLBU659aM644d2Cs8QN+BzLtbY4riligaC7tUoBq9oSfPNFZSTSvBRAfvc?=
 =?us-ascii?Q?WeEWozzAQRkhK706YBgr6V+P2AZ4I7n0tVZ9dJcosbTobvfubay8N1y+4BXA?=
 =?us-ascii?Q?0zm8ZbhvNA7s6zat8Gv8sCBxZ15gXfYxue1EQsV+q79UbLPRO08sPS5XtyYg?=
 =?us-ascii?Q?/Cae8mNDqnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uY2ollBQIn6C1ERpIKqxT6+7naBAnBIfqPU/0G2FYXkkM14R/WSAJWsDY/L?=
 =?us-ascii?Q?5bUBAuXU+H8eoQZmgDTLuRTJYXlEKn/IyGNyUKspDGZPB7+rTzCQ0Ea1iBwz?=
 =?us-ascii?Q?snbQ/GrXzDSBp5zzYlQwL9h5Qsn/NCdcHs1Q5tfrrzfFGQm3OVofKcPxu6LO?=
 =?us-ascii?Q?/ZgsUm2KY8BYBFSxIQj/QGV1dgda8d/jHmKXhNLDFdZgPbl2Z4IT04JzRzDg?=
 =?us-ascii?Q?EPm/c1OfO8TemtTZ9mrMCBnsyokjI9UczQA6Mb937fciE59YoVVmcjloUb86?=
 =?us-ascii?Q?F9hYwvL9isyQtEnCHCv8F05hZPXj1IFs36cG71FEZ94xkwXyu9+x9ZgLWG1/?=
 =?us-ascii?Q?QiZkoL3bq7eVtv5ZWC6QrOFXJWdoaAY4GC4HZ4FSXJXXzKfIHGbcOTNb8Mbr?=
 =?us-ascii?Q?pxfAjgjJbL8R1m0/JCPIN/sB6Z4NCG8Y7pOGkBm/89VjjFfRqlwG6C/Ckm8u?=
 =?us-ascii?Q?ED2cb4exSRQmcZFaHdZVhZJqqzVS9BeXp6suIEESYZJOLzBy5Ff+cxNfI/cs?=
 =?us-ascii?Q?mscgHzCAawnxYO6fWclevB7thMYjmVNYO57iEBy9tNV/MLvzI3wZC1wQ6Spy?=
 =?us-ascii?Q?pptNsKEm9Sxp2bJ9w6xHavRawEiJhk1Zpx0ZHGEL6I/lAb0owdlOP2bkfIXY?=
 =?us-ascii?Q?OlZ+Wq8feFqsy0p7ADrMJdUBroJlCbaSCrGoAFoLvdoCgTyrK97s+GsxxmKI?=
 =?us-ascii?Q?fpdgTlPsCt2dUzrKFpk8xC1Hy7twcWVwInooUBjCx6J0jbA0eYYeG0mWKoQr?=
 =?us-ascii?Q?YVxdTGv2Cx2WG03iGv3abMjrC7KCwLHxPPTOn7vJPV168JDGcmqRny/Ed9Bo?=
 =?us-ascii?Q?+rp3xDTmSfCwZmxpiueHl/yooMv1Y4CzFE+FkINC7GwmUDvw1LiqZ/1Eiw2B?=
 =?us-ascii?Q?Ngt+OFzkZ8xp5djiaTH5LSZZK6tUJPy60XpkQbUcq9e2ftUeKKP5GDM3Gom7?=
 =?us-ascii?Q?sqOADVQ6YRx86XYRFI3YaEoB1ZyQDtekRpFpqmOYnmz5N6f5dERxyhtcDbR0?=
 =?us-ascii?Q?sAwz1/b5nBhOs3LBRg1GucMj5h6QnBlgMZxAa5eHlJi4cPlh4mVFHccgT/hj?=
 =?us-ascii?Q?M/ZX2D5rO+FrwtRarqP02RXPqow65WzzQkF/bnluNmwiQ15jMVN0EXYmjJtb?=
 =?us-ascii?Q?4uv2W7OdI/VWxvOaYTButSs2ChhHymBpeUztnLQDkU9Z8VynGi+axPo2Nxbu?=
 =?us-ascii?Q?ZEvK3zkHss0ea/9tEFXFJBCwrvXII8uXFXg618nT3mM+uciPPPQgonuYQUxz?=
 =?us-ascii?Q?u1xJBQAspOboW+96O+MZZDSN/RX/Ovk/+SOK4MmjZCL16gC/lda6By/HeHca?=
 =?us-ascii?Q?fbiDFQ9UrcGibXKlEtP/G5KK+OOk6YS0sLPYFErdsSWJDKp+tdOH++cJafcp?=
 =?us-ascii?Q?cAg4Gy2NQip3I5qk/xMxmYfMB2Ls50ZGXclqrb6M1tAklS214poRHeaQcS4J?=
 =?us-ascii?Q?oUVuwjSfhI53jLMavp6Wfds8qwUTw9MzYHxfg2asspTQJms2YQtMzITrmn4b?=
 =?us-ascii?Q?poNO97cWWOJm15W0Uxs7ZH9Vl2r2GbrcrGe8SsiGit3kzqejeaDfXf4qdekB?=
 =?us-ascii?Q?x1klarki8ylaPImX0ptPqz5yzj6TxGgwLhJNXmgdY090f2WkMDeESMpt2b9V?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hzVB+2XE/ucTG21pmf6Byl+BjVlXa8GbwxB+ijufH89eT0W9B+tc9Z39pARS3papbPCDCu2EguvitjgwaMfXijUHparYJSo7HAP5FCR1sHa/7M2yB8lA+5pdax0a1GFpxAdSCis3XFgr7SaWSoK7yiF2AlfsMMHyy4ApG6+qX9t4zroJEFBRRoNanqR40tx2nEfP258ZWSKQ0MFqmwPCjve3OaCChl7gv2lbDAHDEico9+A+NwWqNPxF65QaJDjqjiYinYnLUCbynG8vkEnlFzAON6kYXZedNtJH8XRCOVoUVCHeIrdW2w6TvVXIEY0liA04GtsIuXH0mrt/guUySR+hjUOrmNrUHXrhm16fsqpORi+lIwZoaJNsNk0SOzW4RnTLYA4QRqPUp6BonDD6Z135icBNpuPDJ+R9urUEnt9Ztk8/ygqgHqJBVHjsEZ2FOr0c4lITpy0Hq1O6Js2jYS0aY8UIogzWInHQ/7zY6gNmA/fv1mkvHt/nZ5TLCPU6gsI+sFvbl2+QPgzyByaNhcGNDvyXgfMeAveaGfBJ2A9CnG6HTEtBrBCzTJjbNVIlEOhFnzxYTdtbHUUu/QUjd3GzMHKYkmSlslLikYBcXgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac7b2d-763b-4f15-77a9-08dda4173c26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:56:25.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72EM6D8BEov2A2i8/j2zF/yRF7+yYAJp6SSsr+Ylk6ju7Qek2rvTFSHd0V7s8RabWS3bybSxo3wfNj7lx1E+Etoxa/CoTVnAE162LCFyaYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4NyBTYWx0ZWRfXyqSZ8FnO55zm ZQUJy1kCPbOu6wiazuIJjwZtkH0jsktPIVxuiekYBrODyysLirDQMfRKD5GzgX9MSTb6Q9csrY8 vTEdG2aR1HkjjGXhj7AxlSrzOe0+/dFUryfNo+JbhJYizyLmaI10ZYMkFTS8XNerrnSQRAFDX6B
 hJW27+rIP9aFvacjyYr/J/L4lPvrUs8cFp1ffnDY678bu2t2qnqlDIWPnR3Fi4s9DZRo+asIzAl GqynPfHoJy2K4j+3plzGo7u6nPCmPbsgEfKq/aQvq95Avab8Rn554nHCja41cdNxQMb6Gb3Qx62 oAwT5oTmBL9vndsovd9/F3+CB3EW+/L1rUpwDrvNXwirxxtb0bHWhRgbyJpJddbLnzO9QXr3UWe
 Z46y3gDQ1fiD2MBGiRAMF9N8UU0yI6Ne7glLoxjEWtTgohG/tyNoMayUuOxzyHaVgOaKkLsc
X-Proofpoint-GUID: o7ETsZNrtMg3sK73tQfCW3aR2HRuZx70
X-Proofpoint-ORIG-GUID: o7ETsZNrtMg3sK73tQfCW3aR2HRuZx70
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=684169ce b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=kQiiqoMyzOC_fsDMSJsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Thu, Jun 05, 2025 at 05:42:16PM +0800, Muchun Song wrote:
>
>
> > On Jun 5, 2025, at 17:24, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Jun 05, 2025 at 08:56:59AM +0200, Vlastimil Babka wrote:
> >> On 6/4/25 16:19, Lorenzo Stoakes wrote:
> >>> The walk_page_range_novma() function is rather confusing - it supports two
> >>> modes, one used often, the other used only for debugging.
> >>>
> >>> The first mode is the common case of traversal of kernel page tables, which
> >>> is what nearly all callers use this for.
> >>>
> >>> Secondly it provides an unusual debugging interface that allows for the
> >>> traversal of page tables in a userland range of memory even for that memory
> >>> which is not described by a VMA.
> >>>
> >>> It is far from certain that such page tables should even exist, but perhaps
> >>> this is precisely why it is useful as a debugging mechanism.
> >>>
> >>> As a result, this is utilised by ptdump only. Historically, things were
> >>> reversed - ptdump was the only user, and other parts of the kernel evolved
> >>> to use the kernel page table walking here.
> >>>
> >>> Since we have some complicated and confusing locking rules for the novma
> >>> case, it makes sense to separate the two usages into their own functions.
> >>>
> >>> Doing this also provide self-documentation as to the intent of the caller -
> >>> are they doing something rather unusual or are they simply doing a standard
> >>> kernel page table walk?
> >>>
> >>> We therefore establish two separate functions - walk_page_range_debug() for
> >>> this single usage, and walk_kernel_page_table_range() for general kernel
> >>> page table walking.
> >>>
> >>> We additionally make walk_page_range_debug() internal to mm.
> >>>
> >>> Note that ptdump uses the precise same function for kernel walking as a
> >>
> >> IMHO it's not clear at this point what "the precise same function" means.
> >>
> >>> convenience, so we permit this but make it very explicit by having
> >>> walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.
> >>
> >>  ^ walk_page_range_debug()
> >
> > Oops will fix.
> >
> >>
> >> Maybe this could be reworded in the sense (AFAIU) that
> >> walk_page_range_debug() can be used for both user space page table walking
> >> or kernel depending on what mm is passed, so in the case of init_mm it
> >> invokes walk_kernel_page_table_range() internally.
> >
> > Sure.
> >
> >>
> >>>
> >>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> ---
> >>> v2:
> >>> * Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
> >>> * Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
> >>> * Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
> >>>  per David.
> >>>
> >>> v1 resend:
> >>> * Actually cc'd lists...
> >>> * Fixed mistake in walk_page_range_novma() not handling kernel mappings and
> >>>  update commit message to referene.
> >>> * Added Mike's off-list Acked-by.
> >>> * Fixed up comments as per Mike.
> >>> * Add some historic flavour to the commit message as per Mike.
> >>> https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/
> >>>
> >>> v1:
> >>> (accidentally sent off-list due to error in scripting)
> >>>
> >>> arch/loongarch/mm/pageattr.c |  2 +-
> >>> arch/openrisc/kernel/dma.c   |  4 +-
> >>> arch/riscv/mm/pageattr.c     |  8 +--
> >>> include/linux/pagewalk.h     |  7 ++-
> >>> mm/hugetlb_vmemmap.c         |  2 +-
> >>> mm/internal.h                |  4 ++
> >>> mm/pagewalk.c                | 98 ++++++++++++++++++++++++------------
> >>> mm/ptdump.c                  |  3 +-
> >>> 8 files changed, 82 insertions(+), 46 deletions(-)
> >>>
> >>> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> >>> index 99165903908a..f5e910b68229 100644
> >>> --- a/arch/loongarch/mm/pageattr.c
> >>> +++ b/arch/loongarch/mm/pageattr.c
> >>> @@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgp
> >>> return 0;
> >>>
> >>> mmap_write_lock(&init_mm);
> >>> - ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
> >>> + ret = walk_kernel_page_table_range(start, end, &pageattr_ops, NULL, &masks);
> >>> mmap_write_unlock(&init_mm);
> >>
> >> You've removed init_mm from walk_page_range_novma() but I see most callers
> >> do the locking of init_mm immediately around it. This suggests a version
> >> handling that automatically? A bit complicated by the read/write
> >> possibilities, so maybe not worth wrapping? Just a thought, as David says ;)
> >
> > Most callers write lock interestingly, but then one read lock's, so we can't
> > just assume and would need to pass a boolean which would kind of suck.
>
> Hi Lorenzo,
>
> Actually, the write lock introduced in commit 8782fb61cc848 to fix the
> race condition when walking user page tables can be replaced with a read
> lock. As explained in commit b123d09304d86, it is safe to walk kernel
> page tables while holding the mmap read lock. The function name
> `walk_kernel_page_table_range` clearly indicates its purpose: walking
> kernel page tables. Thus, using a read lock internally is appropriate
> and safe. Please correct me, if I am wrong.
>
> To further enhance robustness, it is better to add a WARN_ON check to
> ensure that the address range passed to walk_kernel_page_table_range
> is indeed within the kernel address space. This will help prevent any
> accidental misuse and catch issues early.
>

Hi Muchun,

Thanks for the information. I'll chase up this locking stuff in a
follow-up, if that's ok? As I want to get this refactoring landed first
with the existing behaviour.

I did wonder about doing a WARN_ON(), but I am concerned that perhaps there
are some very odd architectures that place things in unusual locations... I
guess this would be a addr >= TASK_SIZE check?

On the 'weirdness' front, Jann's opinion is that the debug code shouldn't
even be walking page tables without VMAs in userspace anyway (and to me -
unless there's some weird arch-specific stuff out there - I am also
perplexed by this).

So we should in theory just drop the ability to do this kind of traversal
in general.

This is something I'll investigate...

There's also oddities like:

		if (walk->mm == &init_mm || addr >= TASK_SIZE)
			pte = pte_offset_kernel(pmd, addr);
		else
			pte = pte_offset_map(pmd, addr);

In the walk_pte_range() function, which I feel is wrong - you should pass
init_mm if you want to explore kernel page tables, so why are we doing this
here?

I wonder if it's for stuff like vsyscall which are ostensibly kernel
addresses but accessible in userspace... but then would we really want to
walk the page tables for this?

This is stuff I want dig into a little bit.

But overall, would you mind if I defer the WARN_ON() and other such stuff
to a follow up?

Just keen for us to firstly separate out the actual usages of these
functions very clearly, and thanks to Mike's great suggestion also making
the debug usage entirely mm-internal.

This should lay a foundation for introducing further sanity to the equation
here :)

I will properly look into the commits you mention in preparation for a
follow up though to be clear (your input is much appreciated! :)

> Muchun,
> Thanks.

Cheers, Lorenzo

>
> >
> > Also other walkers assume the caller has the lock so it's consistent to
> > keep it this way.
> >
> >>
> >>>
> >>> flush_tlb_kernel_range(start, end);
> >>> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> >>> index 3a7b5baaa450..af932a4ad306 100644
> >>> --- a/arch/openrisc/kernel/dma.c
> >>> +++ b/arch/openrisc/kernel/dma.c
> >>> @@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
> >>>  * them and setting the cache-inhibit bit.
> >>>  */
> >>> mmap_write_lock(&init_mm);
> >>> - error = walk_page_range_novma(&init_mm, va, va + size,
> >>> + error = walk_kernel_page_table_range(va, va + size,
> >>> &set_nocache_walk_ops, NULL, NULL);
> >>> mmap_write_unlock(&init_mm);
> >>>
> >>> @@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
> >>>
> >>> mmap_write_lock(&init_mm);
> >>> /* walk_page_range shouldn't be able to fail here */
> >>> - WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
> >>> + WARN_ON(walk_kernel_page_table_range(va, va + size,
> >>> &clear_nocache_walk_ops, NULL, NULL));
> >>> mmap_write_unlock(&init_mm);
> >>> }
> >>> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> >>> index d815448758a1..3f76db3d2769 100644
> >>> --- a/arch/riscv/mm/pageattr.c
> >>> +++ b/arch/riscv/mm/pageattr.c
> >>> @@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
> >>> if (ret)
> >>> goto unlock;
> >>>
> >>> - ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
> >>> + ret = walk_kernel_page_table_range(lm_start, lm_end,
> >>>     &pageattr_ops, NULL, &masks);
> >>
> >> Note this and other places break the second line's arguments alignment on
> >> the opening bracket. Maybe it just shows it's a bit fragile style...
> >>
> >>
> >
> > Yeah I know :) I know you won't believe this coming from me, but I was
> > trying to minimise the churn :P
>
>
