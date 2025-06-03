Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10811CD215;
	Tue,  3 Jun 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748978656; cv=fail; b=HJRPQnSFuBWrMsNHND4uR/uuf+jtSVahF9rfvRHd+W2mkgRGVsyKtFvbK8ee4xPIBg/sw7wBG5uXcYl6s3sZXMlwAPtC/tukp+Hp/N2o1X+ISUJxM4e9VKqqZRvPZ4/54rcGxpt8wE4b0wYO3jysykET4xnt/oHh2Vq24KiKVaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748978656; c=relaxed/simple;
	bh=SomZLYrVBVlQnloHYweKFaORpta7I7HBFfx7dCJnEPk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zct8PTAeVHauqsDxXdw9UQI+4PIoCp11usFtOfO1wTvndgD1S2FzGw8nWQgtPlILjdjJz13tywrUSCZTsDLtAr4NwS6LSmxWOfKkmSXOmuf9UROpBWqJ8mAyV1jvG415B9N6x+rQMA1U74mzftEJynQgZyhBacfv6vZJCzfxuSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fo8uQOaI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g2pCNjFk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fo8uQOaI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2pCNjFk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HY5P3032365;
	Tue, 3 Jun 2025 19:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=3C+sGEuulGC4tgxF
	2Y8mq2owp2cBGj5Yg3Lq6UB0cEI=; b=fo8uQOaIfnGqiPQdHHGWRU80HFy4rRS8
	Hdyh1pSuWcKWgJODCAI1nj7nMJ1YnU+214qognIROwKpdcIOh+5MaGnkCJNAS7Qj
	BFlGo9nK+7Qu9mxFXFSbLRCwz8sBTdDK/0TdfXnpkTT3dssUb64adt9mxA/jMzCP
	iJ4xKBseTN5eHFrshbPhVTWVRfp44+SH2ne/Vn9+KIfdBFeIi3eUJC8NGYRn/wMd
	2QofUggUlvU8gCxoPADdj8meBn4NA4szcXp6+ts110lUBNvH7cGC/55/1CknQ9RV
	OxXLg/uu0M5VTMNZfX0tVfW4l6avLInO6tbQMFn8rtyp4LWY+w9dkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gak3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 19:23:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 553J0mvS038542;
	Tue, 3 Jun 2025 19:23:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr79v7jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 19:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV98XTgSRMv1hd4RWMQIe7ey738E+f/OQhtB95xtQxSRvtiiB2hvyvDwS7hsL7UmGwkU5Fuv4Vzm6PlDTbcesxhzlHuYa+x012NB2/1W7/wymS0iMC9f+Cc+h6R8f/xowloSDo6mLry9o9KQ3Ur7MEre0u3y4jpiXpswPqHcOeRPfiCpcErJk1sGBzHyHvn4WBq7a0dvW/P6JUeQwHlLtqxuJi5OT+NomHoiQYEyQbpvKpSawZHmcTkL9wJBZwDvUvaVI72GuZnjaeKp/LjngJDw5etCcIjjD+Y6LqO1uitqJCkg3ec0wQRQPfYxjjI4TY7igb7F8vrFWdpaVhh3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C+sGEuulGC4tgxF2Y8mq2owp2cBGj5Yg3Lq6UB0cEI=;
 b=sgPseoEfGkoQqEsSBJsFTDLAiRY0uMNRhUv7imDC/ZlMfwx8PKMLupgueHMLJpVaQ3ExI6CJ2UDZB90vWGzSS/dA10+tK/tIsHB0xf0vA8GRsYhW/6SW2IY7pxEzshjdT21G+Tg9gH1ycoaaUFbAFom33/WLvvnvVGaNkjT5qZPUtOEwyHMRuH055SlCodDzl45RF8swNRLMw9S3Yp8SijewvNaNlmyb18JFhbRdUwxwcUFNctILQAZVj3h61p+4u/Hw+/kRpi+VemyUmC1nJCN8Snq5p245O2s0PnoSW97yGzQCWw93vEcP2VzbZCPwMvhA2tcvrhMiiEOkm5x2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C+sGEuulGC4tgxF2Y8mq2owp2cBGj5Yg3Lq6UB0cEI=;
 b=g2pCNjFkt6ypN2M+LZg7i5N127y/ryzeyT7iG2ilFZxwRmR9rDqEPPSKLxVabc671L3q7Uc+WUkYG9LSjvOHVYTHx8zuFNa0F1aX4UUjFnVlxjKf7hztCbaFHmo/6eRkKKxDUlH+tMZazdLn5GQ8rLcqjWmRw6y2xzTQ/u2CX9M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 19:23:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Tue, 3 Jun 2025
 19:23:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
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
Subject: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into kernel/user parts
Date: Tue,  3 Jun 2025 20:22:13 +0100
Message-ID: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: f2581078-486c-4633-c76c-08dda2d412b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3TToIH7n1VUegnfqbQcTwzchziX+sZZ7t698bu7vzYuzS6BKJ72GXNn0+l3?=
 =?us-ascii?Q?sFe+1oDB26ejH3HqbyQZNlc9hp/nwiMRLCts+K332jwy4wy0bUQXdoFogScn?=
 =?us-ascii?Q?ViSdafpUfrPOqyPNxfrIK6cYiyrWDgMpRQghymxtxcgK50YhX3rDn0R+34lR?=
 =?us-ascii?Q?GNHNBE7B/X5YWyDkACDmQdHx1xhF32L8zV8jgUnPYK4dSJeCV489e1BKMZnN?=
 =?us-ascii?Q?SG6pTNK8L2OwBnll13Yaw97lOtfd8IvsbWvuZa1RRTjYLii/z01dAilW/XX5?=
 =?us-ascii?Q?YXgtTXbKVIyR2392w5WTzi4WpcmSBVAjzG9+YJvo6iztEtevNiH/d5Dfxer6?=
 =?us-ascii?Q?WFThZbzLd3s2PLmGfsJ2anVbKsmJ4blNkH2L5cQ3Mux4FPsLUTTdNEtr0zWw?=
 =?us-ascii?Q?4ecbDOVnXcLeL8VWoUUgHSC+ezam+hePW6aRzOodlr8TNkKbikY51aiDVu9D?=
 =?us-ascii?Q?3Oz9+2SRcjXQhYB4aLiGFp5EqHD88/bx5vleYuUcRDb5DVdzDG9GKR77SLtp?=
 =?us-ascii?Q?tu+pmTN3E/P2LlPmt0cJHAVzho5IbGF8jsKXJ77fbTAdPbFw5scmzYGu1wZd?=
 =?us-ascii?Q?80G3FNTPpT8bkKDD4awOnOoqDM8EKRC2ZmAP+s/Z5GoLp1nuICIAH/2sUpcB?=
 =?us-ascii?Q?w+YhSKRSk7GwlekFNeJ6zAT+Jk3BDS/CaDsYWKewyUqNpj1JOQy7PA1QPX/P?=
 =?us-ascii?Q?nV0AGljZKmkV86t2vktWeYYrdudnYiOFoReSxU0Wu5dZNrWTX+lxEM/GThx6?=
 =?us-ascii?Q?4x/JRaGfBaSavUweHx36cmdwuP/DDqQbbindRzY3FDyznxJVkXbPubMfO1Zk?=
 =?us-ascii?Q?rGwv3iKIjU8ntzYe47sedrgU8lOHNqEuwkFq905atVf1vCcGOSpCO5TLyL/g?=
 =?us-ascii?Q?7jmQZMzI2l68a+yZQQKFtxMgJbFLq1Ox25PfNWrGy855mnCh13DsOfhhqxD+?=
 =?us-ascii?Q?P9Y8iyCGyBdgBvYrviNWvR+vBNq0g8mXx3RuVkeJ0K//oaw0lLvWzVwEqr24?=
 =?us-ascii?Q?7FZA/8UwBaG4mA/APBatv40wfkk6ZCUkOXdcR5wWKr8t8BRVlN5rrgKS25cP?=
 =?us-ascii?Q?yjZ2quvlJIb2SRnAfG3byFkyXxB2FOXPM1gE+Kw5G0b0c8uO0AN4LiG0HOPH?=
 =?us-ascii?Q?VT7jkfFSS9e3XYWxEkXkpApVnxS3yRvQ9pMqkgQxxdjujuNovHQeftVGMppk?=
 =?us-ascii?Q?T3MfrIXPwcX2t7KaK3RUDrw7lRFiwtZrro8IiPsZJuGATC2f9whIwWk6J4zf?=
 =?us-ascii?Q?FVyVKZASqYZwVOhphyzQ6bCiJL+mlGnjI+w3G1UUreej/TFSvcu9NJFu+hxV?=
 =?us-ascii?Q?LxheJY027GAycWK0Ta2dUwCj6objFZOkD91SJTRG0UdrePg9wEJSRzX9M2Pu?=
 =?us-ascii?Q?7r8ZlbtCM8sIhbV4IiZPuHYAwhYwX0ziG79ZpyNRQJZCnhWdqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIrmtIljDBumdHFrMmLtPgaEhhTZzB3/pgwa1cKApRU/oW+MBWagfjt0P1Jt?=
 =?us-ascii?Q?LhdMVogdqD1t/nGAgcqwtxFh8GRBFs50BBnXVZ/m92mXuMWOxCrfXNQ2fCru?=
 =?us-ascii?Q?X6BXQuzZ3C37CMIpzyCLa3wcKXmpIgr4NuBLOElk26BH4xqOAW4KZwGur8Bw?=
 =?us-ascii?Q?Btv4hgeW4a/Bgsf0ISiBYlt3+dH9FkcGGQRZFrt8FLmSnKxnwQ1XwSlsqpKx?=
 =?us-ascii?Q?ws44Pc5hyZ1tS+EVa3wEusI3uuWrPvodWvtTi+5wawoqTt3B1R5K2Yuf/8xP?=
 =?us-ascii?Q?WjVca4pFjXszFH+LK6wqvJKxF+mGLKusSjvsx7G1qpKSXcD92I0xKR+vZ1Fj?=
 =?us-ascii?Q?+RkNxlflyC4dBP2GofrbqxJDLz2nI0THZQSrH56teHoXl1djFjwbud7G77Z4?=
 =?us-ascii?Q?tyQ/QbpkcO2UA3zHE2QxZdKBVD0cD4o/ooFo9cCBoDH20Irgxrd1eUjB+gFs?=
 =?us-ascii?Q?qFwYB8tvHUczN4cN5eR2M/KD3nwVT4snFALT3lb/VMS7EhpcsdGZ1gVBxVT+?=
 =?us-ascii?Q?eBl5nDte25C9mM6yhHuUIMIlEbgpSTRnqFns2lLrm74lsn5zFCOgks3J5vEs?=
 =?us-ascii?Q?WijsH3gEhnLGczSziDSnapLtMROLAiR1wjTwIGwBHywhCxLq1a4o827wxcda?=
 =?us-ascii?Q?X0KWSvV1fbHoykf/dLYJPD4GqZgvsY8by3Y25oIg185USBWennrJCqWCdN/u?=
 =?us-ascii?Q?IFX1rsuhoguQxA0sJD037WM6xa5tM0JoVHOrERu89BlocwzB/uxNEfrJvyb7?=
 =?us-ascii?Q?QZZj+FnyQLniABH5vHjbNwCMEUibHjsvj5p8RmrAPsp9X66zpO6fQNpjG7aQ?=
 =?us-ascii?Q?u09CQJ50MbT37W+6f27ImuKWDb4QgPTNqFZ9elEY5eX5VPZtOXdOnwyXBYrZ?=
 =?us-ascii?Q?98AOUJshtdwM/AI2ySnogBybAkE06M1A9qRmDAKodRxE4VhMGMFwV9RigZF7?=
 =?us-ascii?Q?rkIBfcP3rwNHun5q0l14HACXqpUj7Cc15rtG2/FqSg8KpywTqtOZhq0LtPfS?=
 =?us-ascii?Q?1Gv9c4k4ObCmZV962QW+hUZC73RJfvm9Lny25uYDwpNt6Tp+xaBScpcT3yv5?=
 =?us-ascii?Q?lZtVE9ru8LdIXrZWvDKk6RBVda8UlpjotFpdV2mWmnqzFwVEIsu9P3Qjdnya?=
 =?us-ascii?Q?IL8gUITF807u3vyGAE8+/tIkUyJEi9tTdiBZB8/DDoS9uuYOPnwr9sBZsB5l?=
 =?us-ascii?Q?DxfeWpG6eJcNM02Z8tQZ4Mua0sgb2+oF9RdOtvDL7sxSdSqvmEu6E24Cspdy?=
 =?us-ascii?Q?xF5ohwo+tu7qRGqLR9utOQFUuhdWZ8vEkwmgiK4JjuBO+MDTn3Dg1Kd/VY/i?=
 =?us-ascii?Q?w+oSGN6seVBeLlq1rKYKCzEljcxSS58yV8qnNYmRtj74EuAtxSjkoWbu3Dr/?=
 =?us-ascii?Q?Hz5vMUpQ+CSiE+VOQH3d/+l0wS2dG7JK/WeybY6UzL3qfAvSuu4jj+WlxN4P?=
 =?us-ascii?Q?EHfRZjqEAcRiwr5vJKLK69e2Fsrby3eUuqKIY9NAGjmr6LLDDIEME85mGK8I?=
 =?us-ascii?Q?krXxtvV+IA6dFyMviJMLRsKkk5J/9tOCN8q/nolhumBRsWrzqV3VmeDzkTSy?=
 =?us-ascii?Q?sL9Q5uh4dneUk85et4txO3o5KBKIG4+CO//MLJztYgkQnfEZWMue7iUGzYBi?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vl8ztjLkYcFsAMoE+uGn19YPM1NNjx97KUWIfEvkQ1PIkkJwlE+UupZIJtO6I1MZVSNPz11OU+S6Jru5OmMv5Vs3BSHWCeZr4j6VY3F97ds3rHZB/lr02hKmYMD5wwdrDRE7ZabrbiaxH7hJLv5xzTknPjxZrRXqBDrB9FD3Xhrq/9/bP6eDZSjFBnWvKbABXaEK9V9iZtffoEtf80i2RcKZuEF4S71Ar384PTtYf+VdcgFA0CzUTV8lrikY7CmEKXyVv0dr6gL1Vm5G1FpojkVpNEdoTiMhj4U9hQcHRK+yl/5d8i2aLA7NXdSFSH2xJgVNonpe/kQvfG1jFc0VgyqHjrXbOGqoP98gl00BxwmnL1OIlmkFvTgmvZl4oOeTyo0xpETsR8gB9uHcRtWpbhTKaUvTKUydEjtcRsLAL7GxU7RseJHDjaIfeIchXDQg4TGJLF40IFEX+UjYD/Zfb7v1EWs2D1BYpZceXB3cDCj0kg02p0+8IHbdUTLJ6C6E+vUK7YvwWUeLPE6o0TscUh58MJaz7uTGnBeZ//J5a9qlaxE6/JC+e9vw4kg0v48UXq5ytpBg+/swjY32QPU2O9bEQ8Yf3kOGHmofOEQH8Wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2581078-486c-4633-c76c-08dda2d412b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:23:08.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+k2zrLA1pnlCx59bgQJ4dLSiUaI5F/eIP1v8IbKU9m1lDEzIHphke0Q0Fc99MjyOOPGv2EcjiksiGTc3Cq6WXhQ8h069q4Eq1WhmL77+Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2OSBTYWx0ZWRfXxQ+jpZ2yZmrv 404e1Wblaypv7o/B7pbMFKHlu84AxDNS2tQHD9uwWMwRsiY3dFaZUaJGy/YbgDi9a++WGnbp69E 7L3J9hPTUUEDQI1zoVvMSsoaahtYnpm3140hd0KYdfDNDPDcuI+uFXxgILOd/t8viWMOEyrYs/r
 bhqEKPRsvNKOhBP3FM+UVojHtTqO5csHmYecACBzmKHn1SYzpvwXXS7SbUtaY1sCW3ot5iVPiCr FTYf2jy6S96arfsGDxKiws40ZiZLX0kJEbWC6lHM+Qs5aNKErAOT7iFOe1ro1+488RsSMN5Fl73 kJpj7yqjfKwVJOdDspZTWmIKi2VGlnZNiPHDePJEJPf02K6OfdoH1s/CL4buHpfGgHBO8M8jtQC
 9nwQzMIb2U7Ch9E/kj/N7OQTUGZs9OnmngHeJEQRCoAk9BXL/DmHfOjpHruRuouWkYIaTbIs
X-Proofpoint-GUID: Pw2aCcLT5x_aCiQhQAE-AntPrltbIP2-
X-Proofpoint-ORIG-GUID: Pw2aCcLT5x_aCiQhQAE-AntPrltbIP2-
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=683f4ba1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=p75e62gPh7N1YwvTyekA:9

The walk_page_range_novma() function is rather confusing - it supports two
modes, one used often, the other used only for debugging.

The first mode is the common case of traversal of kernel page tables, which
is what nearly all callers use this for.

Secondly it provides an unusual debugging interface that allows for the
traversal of page tables in a userland range of memory even for that memory
which is not described by a VMA.

This is highly unusual and it is far from certain that such page tables
should even exist, but perhaps this is precisely why it is useful as a
debugging mechanism.

As a result, this is utilised by ptdump only. Historically, things were
reversed - ptdump was the only user, and other parts of the kernel evolved
to use the kernel page table walking here.

Since we have some complicated and confusing locking rules for the novma
case, it makes sense to separate the two usages into their own functions.

Doing this also provide self-documentation as to the intent of the caller -
are they doing something rather unusual or are they simply doing a standard
kernel page table walk?

We therefore maintain walk_page_range_novma() for this single usage, and
document the function as such.

Note that ptdump uses the precise same function for kernel walking as a
convenience, so we permit this but make it very explicit by having
walk_page_range_novma() invoke walk_page_range_kernel() in this case.

We introduce walk_page_range_kernel() for the far more common case of
kernel page table traversal.

While it would result in less churn to keep the function signature the same
for the kernel version, it doesn't make sense to pass an mm_struct in the
kernel case (it's always &init_mm), so we must modify the signature
accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v1 resend:
* Actually cc'd lists...
* Fixed mistake in walk_page_range_novma() not handling kernel mappings and
  update commit message to referene.
* Added Mike's off-list Acked-by.
* Fixed up comments as per Mike.
* Add some historic flavour to the commit message as per Mike.

v1:
(accidentally sent off-list due to error in scripting)

 arch/loongarch/mm/pageattr.c |  2 +-
 arch/openrisc/kernel/dma.c   |  4 +-
 arch/riscv/mm/pageattr.c     |  8 +--
 include/linux/pagewalk.h     |  3 ++
 mm/hugetlb_vmemmap.c         |  2 +-
 mm/pagewalk.c                | 96 ++++++++++++++++++++++++------------
 6 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 99165903908a..b701076605b3 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgp
 		return 0;

 	mmap_write_lock(&init_mm);
-	ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
+	ret = walk_page_range_kernel(start, end, &pageattr_ops, NULL, &masks);
 	mmap_write_unlock(&init_mm);

 	flush_tlb_kernel_range(start, end);
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 3a7b5baaa450..bc9ce5cc2e26 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * them and setting the cache-inhibit bit.
 	 */
 	mmap_write_lock(&init_mm);
-	error = walk_page_range_novma(&init_mm, va, va + size,
+	error = walk_page_range_kernel(va, va + size,
 			&set_nocache_walk_ops, NULL, NULL);
 	mmap_write_unlock(&init_mm);

@@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)

 	mmap_write_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
-	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
+	WARN_ON(walk_page_range_kernel(va, va + size,
 			&clear_nocache_walk_ops, NULL, NULL));
 	mmap_write_unlock(&init_mm);
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index d815448758a1..80e0cd08a4e5 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			if (ret)
 				goto unlock;

-			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+			ret = walk_page_range_kernel(lm_start, lm_end,
 						    &pageattr_ops, NULL, &masks);
 			if (ret)
 				goto unlock;
@@ -317,13 +317,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		if (ret)
 			goto unlock;

-		ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+		ret = walk_page_range_kernel(lm_start, lm_end,
 					    &pageattr_ops, NULL, &masks);
 		if (ret)
 			goto unlock;
 	}

-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_page_range_kernel(start, end, &pageattr_ops, NULL,
 				     &masks);

 unlock:
@@ -335,7 +335,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	 */
 	flush_tlb_all();
 #else
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_page_range_kernel(start, end, &pageattr_ops, NULL,
 				     &masks);

 	mmap_write_unlock(&init_mm);
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 9700a29f8afb..1c2dc3ae0719 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -129,6 +129,9 @@ struct mm_walk {
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
+int walk_page_range_kernel(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private);
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 27245e86df25..724033d9d4a1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -166,7 +166,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));

 	mmap_read_lock(&init_mm);
-	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
+	ret = walk_page_range_kernel(start, end, &vmemmap_remap_ops,
 				    NULL, walk);
 	mmap_read_unlock(&init_mm);
 	if (ret)
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e478777c86e1..d27347ffcd63 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -584,9 +584,28 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return walk_page_range_mm(mm, start, end, ops, private);
 }

+static int __walk_page_range_novma(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= mm,
+		.pgd		= pgd,
+		.private	= private,
+		.no_vma		= true
+	};
+
+	if (start >= end || !walk.mm)
+		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
+	return walk_pgd_range(start, end, &walk);
+}
+
 /**
- * walk_page_range_novma - walk a range of pagetables not backed by a vma
- * @mm:		mm_struct representing the target process of page table walk
+ * walk_page_range_kernel - walk a range of kernel pagetables.
  * @start:	start address of the virtual address range
  * @end:	end address of the virtual address range
  * @ops:	operation to call during the walk
@@ -596,56 +615,69 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * Similar to walk_page_range() but can walk any page tables even if they are
  * not backed by VMAs. Because 'unusual' entries may be walked this function
  * will also not lock the PTEs for the pte_entry() callback. This is useful for
- * walking the kernel pages tables or page tables for firmware.
+ * walking kernel pages tables or page tables for firmware.
  *
  * Note: Be careful to walk the kernel pages tables, the caller may be need to
  * take other effective approaches (mmap lock may be insufficient) to prevent
  * the intermediate kernel page tables belonging to the specified address range
  * from being freed (e.g. memory hot-remove).
  */
+int walk_page_range_kernel(unsigned long start, unsigned long end,
+		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
+{
+	struct mm_struct *mm = &init_mm;
+
+	/*
+	 * Kernel intermediate page tables are usually not freed, so the mmap
+	 * read lock is sufficient. But there are some exceptions.
+	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
+	 * to prevent the intermediate kernel pages tables belonging to the
+	 * specified address range from being freed. The caller should take
+	 * other actions to prevent this race.
+	 */
+	mmap_assert_locked(mm);
+
+	return __walk_page_range_novma(mm, start, end, ops, pgd, private);
+}
+
+/**
+ * walk_page_range_novma - walk a range of pagetables not backed by a vma
+ * @mm:		mm_struct representing the target process of page table walk
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @pgd:	pgd to walk if different from mm->pgd
+ * @private:	private data for callbacks' usage
+ *
+ * Similar to walk_page_range() but can walk any page tables even if they are
+ * not backed by VMAs. Because 'unusual' entries may be walked this function
+ * will also not lock the PTEs for the pte_entry() callback.
+ *
+ * This is for debugging purposes ONLY.
+ */
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private)
 {
-	struct mm_walk walk = {
-		.ops		= ops,
-		.mm		= mm,
-		.pgd		= pgd,
-		.private	= private,
-		.no_vma		= true
-	};
-
-	if (start >= end || !walk.mm)
-		return -EINVAL;
-	if (!check_ops_valid(ops))
-		return -EINVAL;
+	/*
+	 * For convenience, we allow this function to also traverse kernel
+	 * mappings.
+	 */
+	if (mm == &init_mm)
+		return walk_page_range_kernel(start, end, ops, pgd, private);

 	/*
-	 * 1) For walking the user virtual address space:
-	 *
 	 * The mmap lock protects the page walker from changes to the page
 	 * tables during the walk.  However a read lock is insufficient to
 	 * protect those areas which don't have a VMA as munmap() detaches
 	 * the VMAs before downgrading to a read lock and actually tearing
 	 * down PTEs/page tables. In which case, the mmap write lock should
-	 * be hold.
-	 *
-	 * 2) For walking the kernel virtual address space:
-	 *
-	 * The kernel intermediate page tables usually do not be freed, so
-	 * the mmap map read lock is sufficient. But there are some exceptions.
-	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
-	 * to prevent the intermediate kernel pages tables belonging to the
-	 * specified address range from being freed. The caller should take
-	 * other actions to prevent this race.
+	 * be held.
 	 */
-	if (mm == &init_mm)
-		mmap_assert_locked(walk.mm);
-	else
-		mmap_assert_write_locked(walk.mm);
+	mmap_assert_write_locked(mm);

-	return walk_pgd_range(start, end, &walk);
+	return __walk_page_range_novma(mm, start, end, ops, pgd, private);
 }

 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
--
2.49.0
