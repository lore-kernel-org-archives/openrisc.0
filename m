Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5226ACC;
	Wed,  4 Jun 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046932; cv=fail; b=EHe5XE0CR3+oj/Zt/5HAY4cu1hMM2EJ8NepsWfC6mN317ED1fGXNDflAzxHjv4kMFFVRFIhWFJskztr+q+VEOP4INrh1/CRhl+kFLDCG/rZHayBBykH9AtVWI1r0EfYkeFT+eFQ+wrvBYwow/Jelw/e4DT4xOhJSKtONfkztmPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046932; c=relaxed/simple;
	bh=MzCm50KLVuiV+3Enk3CBzrmbprVZ4/iPg8FnFg1pJsY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W5e6G1AdWfxa/ch2ywGV6ytgUIpg7dRmaYeESNyRB8SkkaHEElaivJO83NUsSORu3n5RJplaqRVsLDBKS59O9Vh3D8K213JMFKeeU+qxiNivyySquFYX2oFccIPJ9CfwkQhJHJwr7B/5+G19EACdZeCG+S5+Iblw4Rwv9p9nA+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XhzGaf79; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mhb1KCg+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XhzGaf79";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mhb1KCg+"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549Mep9024844;
	Wed, 4 Jun 2025 14:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=aU83xWJIERr3iW43
	f+ewF5qwbyBrubl5/Z9nmt9Fk+M=; b=XhzGaf79vFp0vJaniS4RVxqKfcoeTh3u
	43jXvg7+mK8fqBJwXn2rZDWWGBE18YY21wImnk7a8JYKFzAEbPunQ0Q3DUf3yzOb
	T6Z7blY1SyHVsChnQ4leQlDEYFH/TCXavVKV/GG2Hsse2741k8tsD/mN5rrcq2nm
	zgGQa+9jvM2QhRZY8Q0qgdnzkZ8FzFg/Pee8oFxHKYkhwiEV/gDOwTtmlBEYOX8J
	NK8Z+kaAO8d7khvMdtSo0lUgAcsJ3BqIbDph5xo5yc/JMjwUG9/4qNd1qlCIuJEF
	4yk+rzBy14cs/DoDEA6JkWrAgO0aaJr5cEdZCDClyuFcpClvdyafIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gc3eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:21:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554DsM7D030726;
	Wed, 4 Jun 2025 14:21:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7atu6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSlZUq1o57OJrcnXzGIY65wIeF/+LcnvAos1iYOfKkHwgu+FN4ekOljuJbi3TZwvyXG/bvLoT9frchQJyBWWGo3/XYoSCn24RMXj8xzR1Phl+SdgF+PInHsVd6JcsdoxSi5Up5ts4MC1K7aJ8/Evf3bgvPaFLnEBn139RRt9Sm8Iq/AXR/dURrKhjxbYl4hXdu1HQZ5rbBXN5xWC/4hcvTT2Mtks4qRo05MNdPTfPH2Dnbss/MxBKJyyNj9SAygiqVgJBdEuUfcIJu1yUSgpkBkrxkrbsEjAxzz/pLmlThgbTT35u1mBXbNAij7gkyh93lv1O2+cRvScTSiC4SN46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU83xWJIERr3iW43f+ewF5qwbyBrubl5/Z9nmt9Fk+M=;
 b=kcUrAWOm7TAovt+AbCSurJW2ze0PUf9RubLGu7lVYHI+iLqNAs03pXCBPokUpxe3yWVY68v2ZAEoYTlOu6GD7ZyriXgvtir2+06ju8CkaTU1bEuPq6C6pex69LgLTT+GwGnaeF1dVmu4IGAiS6Se3I99OZkjYnJmG8ddnchZ7wlaCAdMmAgpeYDQgdDyria43C8keahqGl8vR6YRI+LA086r4wnlLYnmzV6ff/HuN7VXfJAwukS6k361q/reOywbJzxqVXuP5Lt8Yzadi1OdOfvGcLXhJHw1VozT6r6hSHRfy5qzPASLGo7LofXy2SeYhp0X0ssWC0mDprgK9kO84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU83xWJIERr3iW43f+ewF5qwbyBrubl5/Z9nmt9Fk+M=;
 b=Mhb1KCg+Wqk5akFsl6ZybSbyjWj2w4/z0mrBDbP+TDWL9mixWh+6IqrGpvVsMhgtrQhBzs462ETlD9T4/t+BGIvn/AQUFkA7jmZ2sBL6ebP9YWktg6q1pGbPqqKLcU29TUWn0eHSPZ7mv/iqFoJgkr/9wjxNKLQ5hTPmtKWRlnM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8616.namprd10.prod.outlook.com (2603:10b6:208:57d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 4 Jun
 2025 14:21:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Wed, 4 Jun 2025
 14:21:02 +0000
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
Subject: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into kernel/user parts
Date: Wed,  4 Jun 2025 15:19:58 +0100
Message-ID: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0490.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7cfe31-e1c9-4707-ad3d-08dda37308e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tatZpPIztYNvaBCaxqerTDcY9lsefx73fc4WidCP3u7nGOGbwKVGZbfxBZ4l?=
 =?us-ascii?Q?UVWDvZ3NhsTP1Rwn+Yo1rvAQQhmhfYFO435pHTrdRCCT7kFGJEG2vhkrGVSw?=
 =?us-ascii?Q?bMX7NXB9A7nqI2tnSPCa5p2BtQncZY7MNOufSUO7CueZGAagAbhhvnS/Uhe2?=
 =?us-ascii?Q?BHvqjIKR3FppHb1tfZPKexE6SRs3xTf2e5XDlnbNBgSgSFe5bex+nuB7S6Ey?=
 =?us-ascii?Q?6nN4Di2+e/t2T0M7WBNjWzZ0BON5B8rXz4KeaS8LwTnkawPm0JY4iVSkxkRs?=
 =?us-ascii?Q?aQvsefhF4bBNIS53xAJYLFCEBXSgeacyOTPL1VmNFUSOR0SohVsfXOV9Bfqw?=
 =?us-ascii?Q?LzSqtXvfNFvHFqjRaNw1xfwvAjqdqrWcVrmhZHG5nIIVrk9EdsJWpFk2DTK8?=
 =?us-ascii?Q?V82C16yY9WLBd8P0xsJxc1Z5/CQiSjCw03tvb67XY1+xQSiMSrux5mtJrg3M?=
 =?us-ascii?Q?5DXqbojgceZ7KNnHm6iJoUsL9NGC4Y9jq+P7o8IDw7t2yqihOn+kOfUEQEbV?=
 =?us-ascii?Q?nhGvi8kU5EctOPlMK1XxnOA1ToV9T5lgitzLXa2W3lL9QDSKvmwX7iVTwCNN?=
 =?us-ascii?Q?ln357EOnqDYJIOSUJaiqiH+zJYt6PNxjIEEPlpMk1941w+AjDJXsrZFicM0e?=
 =?us-ascii?Q?RD4L7Ivm8L7EFYtg7Z9yLjTucLjigzIrNV39qdrJZOB2F+kiPF+mldYlSYO6?=
 =?us-ascii?Q?h664dz3yFyg+yjEzYtaC0P+xrbsx4qaTK5yy/+AImtTzeEcBwEWwRzJcNlhP?=
 =?us-ascii?Q?tkbCadcAYajICHPEbzCI1lsrtjZA8Gd8ZJwAmd+7wVqa0l2HYZdljqcr2QRq?=
 =?us-ascii?Q?ArjoOm7uiqDMqnYGvk6nE/uOeFzLp9l26mec5R63AjaezznCoL6qS597Fcv9?=
 =?us-ascii?Q?1B4mgvClimDHhbPrI3Svl8sBEyWrA1jUxHyBXlsMewcJYm2IzKhg1YqOSZ32?=
 =?us-ascii?Q?t3t9pI0qOvwtv/+GVCAT5Xy8TU+l/aFcbHFAe9oB3tm1XgIvaOR5NNe5OpdI?=
 =?us-ascii?Q?OcocMkbD86l4mntmsK2KR099+FCYcT5H+2PJAwupYcZouvW2kAV7QkbI/y7I?=
 =?us-ascii?Q?1+3RzvdMtnk2IsyhsP/kZeLt5zgF56zlBfifJZiJGH18Q9L6HlFeo9kxU88+?=
 =?us-ascii?Q?qB7Kjy85TrqIFxDkSnk6Fv289HI5tdZ3erXDFK0xuDAfzU30qWlBFFNynrC7?=
 =?us-ascii?Q?LnXfqAq19SYEQAygs3MfKxl1raCzg5LSWGZ4q/Byrg2/evABS7VVvqhAinbl?=
 =?us-ascii?Q?HfBbses74ILyOutdeocLRypU7GWljV0/a79Zi81QY8Fd7o0lyynle3O/M/8C?=
 =?us-ascii?Q?gQA2i/HQ7ZlvdSztgieN8eNkMwSAcodq+hh47jdAFxgxzZ02PUkaoFwMWtBr?=
 =?us-ascii?Q?IRF99tsetwkpJrO8SFCcGiGtd77KGxIyYWsY9ouXDrCSTVrb4yVtEXqizpJ3?=
 =?us-ascii?Q?osFxkVYuVaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2iobeLQvGlYR2C030S0vs98XdJFWry+Qdr62dFA0OXuGg5L8hDpbfY6v/06I?=
 =?us-ascii?Q?v8f1YfiviXO6iE2rHe4eZc01FFPGCZuR2J1QxE3l8sRV2mPvL73OS5Q5C1v5?=
 =?us-ascii?Q?aMMJNzoEWM5yNLHiPSy1XKT+xO1kNdODNDuoK9F/rfqH98RVto0NwO5S69Kj?=
 =?us-ascii?Q?v00lQ6K2/wlfgtmZVa73iDH/tb9oLI1pPOUHZbvVfKaGHYGdw9BhP2shhxe8?=
 =?us-ascii?Q?Z33pY4nNcSnFeUcGIT1+LL+LwivzAGCWspRft3eIuwyJlFvburyvI8Gwtl7d?=
 =?us-ascii?Q?RKNEAZI+LntzAO9PNq9ZQvI64E+0+/fVvNq7GnVFP0+ZlS1JsdmDiBbnRPfe?=
 =?us-ascii?Q?FutSAiv5Syt8DQu3kabxF4bwX32/WbGv1KVG8D7/FILV0TasZz2hXRO9qxMo?=
 =?us-ascii?Q?OQcKxhDhtoxLNUVzQrGO+22ZpWs2BJjtW8apPH4vApL8ZD7satnjKPWP7kcI?=
 =?us-ascii?Q?G4ztWYYKODkWwd2lZWCOXNIMVS/ytIo4R1EB7+VPQiGKUR23hHW/ARjDrFmo?=
 =?us-ascii?Q?5+JRbE+ygJ1AJvjqHLwxGCXJqSSARIEs1J5d44u4qNPd+U25QVGFA10j7p86?=
 =?us-ascii?Q?WkLox1DIm2rjh24i5QvISduZcWSIpcd0lZOptYqnGQ5EQ61+kObhEjbPgmvl?=
 =?us-ascii?Q?CZxeOydXDXfIComgiYexdWOLqXSlr0Fsx2fh3yRXsOGoyXOXPADjjjSDdj12?=
 =?us-ascii?Q?7a3iwTOtzmyFqNAXKVjchx1R5ryADFpwfQp77NpyXKc9fJ/5ChBmdRLixK1r?=
 =?us-ascii?Q?cS6w5/ERhvUv6CEoNvnC9VgQMoZhgG0SIu7bBn5jHfHKbdi/wu+rYWsQ8Uw6?=
 =?us-ascii?Q?nYoZ7RluR13WsZprw3hbKDGD1//JOPKFowgWgOsuoj3hhf68tpZqrk6pjx1h?=
 =?us-ascii?Q?WWyrS77pdprUpDqIn1lzM1GOH0Eht1An1ZgNlaHLy+I5tNH/4DimAU+xjoxT?=
 =?us-ascii?Q?3ptJs+HlUu6L78V+RqalMRa0rnA7laGr3AMZQxRd0JBDe/SGqksnTzgeEapN?=
 =?us-ascii?Q?n7c+PfPHdQ5iL6RAVJcHmfRL0HutRrCE8tv3DgcAjwg64FceYd4pIZVurZNq?=
 =?us-ascii?Q?Ew574hSaUU5LUNKkuS/0xwTPhUP/B5l/OZGtbcG94xhREqUa0E0pFLv0EJ6/?=
 =?us-ascii?Q?3aqXAEkqlToS6pfq3whulnALlf4EjcTp3dHKB+asfaUZH14cXumbNKkfoQB+?=
 =?us-ascii?Q?8S6pUwGkM8pcpruoEfOIqskvIFIBB8S92lZ/Hvufw65I50mRUY9ShJPHoRo9?=
 =?us-ascii?Q?rOCRmvmHgLg8HR9rrReRrAaPuNFzxHSMsRHyKGBSb0tpLXvSFcfhbefxCKr4?=
 =?us-ascii?Q?PB+AntFz+8su+MKyVLlrQ4Lg9xaLyCs7MZXpg4R5oRa1/yFaKy3X+zW8uREu?=
 =?us-ascii?Q?bIDSQFqnLDnfAux38QwgQgEiO4ccYj4e+B9p3FbLg5YOBMmaTndLEJeAQp/a?=
 =?us-ascii?Q?yhTeJdpZ/+c7HhFeyTsiKKeew1+WdiO08AxLqmPsinFivUM9tlQpCxcgEHUt?=
 =?us-ascii?Q?NjTXQEEUqrMqybuqYko/68C8Ek70iEWxZsx2/dh/bsWt3Bw/6/1NP/L8fOK8?=
 =?us-ascii?Q?/StzCw8nSY6/nx8gkVfZcEFq4c6EfXSA3fgoAXjy7Gj+/IGVhco25LfTYa7c?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IgofUlTqL5lv6f/nWdOayrLQ2z2T8ZYjnI7WofAne5JXhpR59R9RQAyvys6CPuc/C2yEnMaQHobq6xz3txgAWDl/DxfU6Bqxpa2zwxvpLnvryziFdnoqcVeOKJ4t5uJHGAQU/Ghh3l4jNH5VTN6sh/MoWX3UHAfSd0MYvKO79b+jm6yZgbXzPqeH1xnT0gGYXzoY/GlRZjTEeGxzEmV5cRSEg5YgaBrkpi0YLaBwhESuFRsUFrEG/Vxu8W6BK8YYq3Ok33sidKbNXA4TbbWJAbRCqif6JJTnbf4uo9GDtUWNvN12XcsGWjHPEF59SmR9zoPYJnelC2cSmVd2TAGMLAz9qR0wVcF0WULWsFm4ajIe+cXhVxD/FRp63CuNpst29vJDR343OLlcASLuQeeIr7QJ3thfOxWKykHEtTBER4ai0ghjhyCggmKWmfZyE3QS8aCXCNhpPPq3wSkCELH/J9DwWsvguCygMfyhgHcYx0GHEsMiUMY15xSJADsTP/dx5lPwHwGcGTk0qV0NFPY+10O9fC2v1lqVhM3ugaEQWRbqBKiQXJvslH2fhT3zymEIkq1KreigPZ9A4XTGpRPgZkldTADeAKJwtYlion0T/Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7cfe31-e1c9-4707-ad3d-08dda37308e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:21:02.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRgqBLeBd2joOa/bihfrko8uwviDtxvG0baahDA6pHG3AX+MC26MjShoLVzrRR9yet2Vz9V4vkz7vFwuNNfoV+rQfc3z8GJsCapaiOh3jsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwOSBTYWx0ZWRfX1amfuMoqRMN+ LEzfFrBZoFuhYmCaaDSCzKKNsmPb+/EFokNb4J6lLxb5gsDf5vR6z3NI30EOaDQBlA7tIN7ElxC jRPzI9tQKBsmP2eFuUNmE2qIXbyyKODSWLSjtOdc7jX8QgXYd7FB+WHG4GBK1B+7s6vt5cj0Z+e
 do9zkr6iOcZUF3BwY3SvOjxwKokZ1Uozw43cl0joPi3KkmUSEr8tKS9NdJAsBknpAwSDXsB1RJv kY1GeLLi5kE7ni4u+D/VfUm3Rk9ieq7Ec43+Mca0ALcvDcMkWRNAx5LO2bCkD0Ziwnc2LSpgA7Z ofc2HVBXd6f+mWIbImhhh+1gmh9IoSpUXaU8sf/b2fUEpObfM56OHLM7RTN+e3YocgPPIrR6CrA
 1KwVfS93/6iJ5nF7g8OZ2ROd5yihwrgF2Aw+BQTbVzaWRr8bJvdK3p9kidHUYtQsbWgrLJmf
X-Proofpoint-GUID: 0Du9SEdNWXh8UFAPZDwQIQYvNouWW4up
X-Proofpoint-ORIG-GUID: 0Du9SEdNWXh8UFAPZDwQIQYvNouWW4up
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=68405652 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=OuE4BUwA5CVBbw1S2bEA:9 cc=ntf awl=host:14714

The walk_page_range_novma() function is rather confusing - it supports two
modes, one used often, the other used only for debugging.

The first mode is the common case of traversal of kernel page tables, which
is what nearly all callers use this for.

Secondly it provides an unusual debugging interface that allows for the
traversal of page tables in a userland range of memory even for that memory
which is not described by a VMA.

It is far from certain that such page tables should even exist, but perhaps
this is precisely why it is useful as a debugging mechanism.

As a result, this is utilised by ptdump only. Historically, things were
reversed - ptdump was the only user, and other parts of the kernel evolved
to use the kernel page table walking here.

Since we have some complicated and confusing locking rules for the novma
case, it makes sense to separate the two usages into their own functions.

Doing this also provide self-documentation as to the intent of the caller -
are they doing something rather unusual or are they simply doing a standard
kernel page table walk?

We therefore establish two separate functions - walk_page_range_debug() for
this single usage, and walk_kernel_page_table_range() for general kernel
page table walking.

We additionally make walk_page_range_debug() internal to mm.

Note that ptdump uses the precise same function for kernel walking as a
convenience, so we permit this but make it very explicit by having
walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v2:
* Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
* Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
* Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
  per David.

v1 resend:
* Actually cc'd lists...
* Fixed mistake in walk_page_range_novma() not handling kernel mappings and
  update commit message to referene.
* Added Mike's off-list Acked-by.
* Fixed up comments as per Mike.
* Add some historic flavour to the commit message as per Mike.
https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/

v1:
(accidentally sent off-list due to error in scripting)

 arch/loongarch/mm/pageattr.c |  2 +-
 arch/openrisc/kernel/dma.c   |  4 +-
 arch/riscv/mm/pageattr.c     |  8 +--
 include/linux/pagewalk.h     |  7 ++-
 mm/hugetlb_vmemmap.c         |  2 +-
 mm/internal.h                |  4 ++
 mm/pagewalk.c                | 98 ++++++++++++++++++++++++------------
 mm/ptdump.c                  |  3 +-
 8 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 99165903908a..f5e910b68229 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgp
 		return 0;

 	mmap_write_lock(&init_mm);
-	ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
+	ret = walk_kernel_page_table_range(start, end, &pageattr_ops, NULL, &masks);
 	mmap_write_unlock(&init_mm);

 	flush_tlb_kernel_range(start, end);
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 3a7b5baaa450..af932a4ad306 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * them and setting the cache-inhibit bit.
 	 */
 	mmap_write_lock(&init_mm);
-	error = walk_page_range_novma(&init_mm, va, va + size,
+	error = walk_kernel_page_table_range(va, va + size,
 			&set_nocache_walk_ops, NULL, NULL);
 	mmap_write_unlock(&init_mm);

@@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)

 	mmap_write_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
-	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
+	WARN_ON(walk_kernel_page_table_range(va, va + size,
 			&clear_nocache_walk_ops, NULL, NULL));
 	mmap_write_unlock(&init_mm);
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index d815448758a1..3f76db3d2769 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			if (ret)
 				goto unlock;

-			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+			ret = walk_kernel_page_table_range(lm_start, lm_end,
 						    &pageattr_ops, NULL, &masks);
 			if (ret)
 				goto unlock;
@@ -317,13 +317,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		if (ret)
 			goto unlock;

-		ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+		ret = walk_kernel_page_table_range(lm_start, lm_end,
 					    &pageattr_ops, NULL, &masks);
 		if (ret)
 			goto unlock;
 	}

-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_kernel_page_table_range(start, end, &pageattr_ops, NULL,
 				     &masks);

 unlock:
@@ -335,7 +335,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	 */
 	flush_tlb_all();
 #else
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_kernel_page_table_range(start, end, &pageattr_ops, NULL,
 				     &masks);

 	mmap_write_unlock(&init_mm);
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 9700a29f8afb..8ac2f6d6d2a3 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -129,10 +129,9 @@ struct mm_walk {
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
-int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
-			  unsigned long end, const struct mm_walk_ops *ops,
-			  pgd_t *pgd,
-			  void *private);
+int walk_kernel_page_table_range(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 27245e86df25..ba0fb1b6a5a8 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -166,7 +166,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));

 	mmap_read_lock(&init_mm);
-	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
+	ret = walk_kernel_page_table_range(start, end, &vmemmap_remap_ops,
 				    NULL, walk);
 	mmap_read_unlock(&init_mm);
 	if (ret)
diff --git a/mm/internal.h b/mm/internal.h
index 6b8ed2017743..43788d0de6e3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1605,6 +1605,10 @@ static inline void accept_page(struct page *page)
 int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, const struct mm_walk_ops *ops,
+			  pgd_t *pgd,
+			  void *private);

 /* pt_reclaim.c */
 bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e478777c86e1..057a125c3bc0 100644
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
+ * walk_kernel_page_table_range - walk a range of kernel pagetables.
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
-int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
+int walk_kernel_page_table_range(unsigned long start, unsigned long end,
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
+ * walk_page_range_debug - walk a range of pagetables not backed by a vma
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
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
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
+		return walk_kernel_page_table_range(start, end, ops, pgd, private);

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
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 9374f29cdc6f..61a352aa12ed 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/ptdump.h>
 #include <linux/kasan.h>
+#include "internal.h"

 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
@@ -177,7 +178,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)

 	mmap_write_lock(mm);
 	while (range->start != range->end) {
-		walk_page_range_novma(mm, range->start, range->end,
+		walk_page_range_debug(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
--
2.49.0
