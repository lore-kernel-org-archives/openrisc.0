Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0E25E455;
	Thu,  5 Jun 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131523; cv=fail; b=spRFdgF0ZmhFlPzDmMfhwpTxuMVwZN+5O+fVSG9xnm+goHQjGptPthIo13ZuWnCtnSN/JbwvkJLA3fDCWlGdbEagvKw+q3aZvidMYxdDQbB24kCmYdLVYANV2cjA13gyrsRuVL/R3aHUTVH2KB6K4MHhZoz+XlJNDUlVmFams0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131523; c=relaxed/simple;
	bh=6Uyqb9dr20ol6OdOGmGA3nL7sl5eWztG9LbMV2OHORA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HlOGfQDnp3JPREj8gcs1m5iHxgQAzEMEyMvxF9pLXg0cinhbRfWMLO3mtNX2swKZnkxxhNSSMN+3jIxY0k7XA1mdlgSTOuvH/R0bk6ckMYW8kkgcjahJhEvubraZHHn+MnTLmgeJBraFh7Cjm35J5E5L+Gdwe68eDTXVEuCDzdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YppDkwiy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l0U3aOcg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YppDkwiy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l0U3aOcg"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtUKQ023841;
	Thu, 5 Jun 2025 13:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Qy6lb69hUX+ChUzU
	/Rg9pFGzQRdAj9leBElrZAQB2Tg=; b=YppDkwiyHipcxxUPZxkhdsDyN/cvD9Xo
	kmi/oqF7DvhGl6XnsV9zZMsCwNYyfqq9rnDWRY1yHeyXW8ywIQgb41aIPnfRe524
	t962OVpnk0XtekwFmkLwmvu4R51QhK0Vr1l8JP1WPm03XdcsbiBpT3luxKVCFra8
	e4466fxznf2uYltrtlcxTc+6/+h83jol6hqEkWu02yJplGXWRkjYmNiJhMIqlIKn
	lb5kbU6iB2KuUkwS1NSLVJkeH76aWhmY9K+K3DdLem5UrejjIJf/PmyMs0n0Y0IX
	7NZYsluWH8r3NDsu2ssHgqsEfCNfn90Ss3Wwd5hyK+82VkzAF+8K+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahe8vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 13:51:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dc1Eu030599;
	Thu, 5 Jun 2025 13:51:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c3max-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 13:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwlXFIriT294MTQpBgkBiE6OsBmmpNRN4iFkcxEptJLzf9DYSPJs6CHZwkQbicvCc4qDAA/OZg3e0PyK2zJhdYH+x3O3jIQc4zI2U5ae6KotsXnGckD4yhCsrUxQzJy/l8IocLoJmxoCvUPv2zJLIWc2aPgxkNADyoKfJJlwY0ovVmlnHGr73uJY1JfbVC8FHWgjR+zmKMbkvWa/J46jR8pAOpWd2CTP85+PAKKGUFtT7y17ePj0H2Wh/+rIpyX5d/xyaC1mOCgTHx6/AD9voTKOPUKfJzslTBdxM1PIsdSNQTY9gbN8xB7PHf/9lTAssQV5tipESDzoZmn2vnx9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy6lb69hUX+ChUzU/Rg9pFGzQRdAj9leBElrZAQB2Tg=;
 b=JZumYLQOgOKGyVqM5rkpVdiv3i36kb8Zl5UCmZQJQiwmW38lU06+/UF19qBFwk6M0q/dMIBSHz0krXbdItPJUXKuYc9b8dq+0t5Hqpii5zY1OLxlnKE4u8RXTYbfhLmpMoyJnkIJ2yJL9v0c2DxsAmZmkWZCYd8p01wKGcyQdiZ/2X0pG35AG7h1Xjme/0zmqBnR6+syp3q5uaxQll05VoVT4MNB/jSY1kbcYQDu1760CiOc4VfU5akMOei7ZfNUXtYVlbz+Ia+cx/uzMfofwEeM6+YJRUWMCsMoZgI+8tYpwUwP6GKOHV6oXzrlJu8oXWWnS6paXtxnNoJJE52uOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy6lb69hUX+ChUzU/Rg9pFGzQRdAj9leBElrZAQB2Tg=;
 b=l0U3aOcgc3GwExGJRkJOr8F0wCTdXH6LzpDmNM55rRpHR+hSxX176x6LGaRmCgYpA7qHYmlGWAFE402cvqxTLuzYqMNsyrEM7eePWiqyhFIp66BLDsywotTfnWClKhlEz+sMxv2dVWMjO8cDpPqObONYecsNn5F+jeMgix5k4sw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 13:51:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 13:51:07 +0000
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
Subject: [PATCH v3] mm/pagewalk: split walk_page_range_novma() into kernel/user parts
Date: Thu,  5 Jun 2025 14:51:04 +0100
Message-ID: <20250605135104.90720-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: d35bca3d-16a7-4a62-178f-08dda4380553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqPEZqD9e4fuSTVFQXnZSrV7B55N+2lVo1Ddx9QSPjAXZzFaX6Jq+4q+mRO4?=
 =?us-ascii?Q?TU7+ttabWLd8q8H9hI8tDaG00nmJAZ2UAdqwCbLjktVNzbZqp02GOYNLrohy?=
 =?us-ascii?Q?xPWAEkWSktnz5LH/HNENExOYq1qj9uQxUU3PK6ErsqlfWYNtVmAwClnRd0V/?=
 =?us-ascii?Q?YmSs9+egcy08gJGSwEiQnVfJZ6ZX9SZQwb2/AvGARWTpIX1wjU78/026doaE?=
 =?us-ascii?Q?z2Gx/xTzINRXuNLZfpYbFhJcv8DKLZ7GaEXiDN+TM+BaSJ0bLfM4K1q9xyXB?=
 =?us-ascii?Q?5FT4xDaQ8y+kW6745K9kGSwrNclk2d8d6+kaqF65F9DfwHA9OoKEhweNaPJW?=
 =?us-ascii?Q?eu5gdJ5gXFdVebHe2Lmu8YVnPQNDov0m1xHRJDv07WniGPJoeNLCtmxfRrJy?=
 =?us-ascii?Q?aclPlClET1XIAvjZW4ZPCeWc/XOKXeF6ae1sMt4KwZcr2+8YJRTkSdQY5wO5?=
 =?us-ascii?Q?rVo+vgFNyyCMmidCgWpVBBoh8bQSS+PxjlKegxy5yjsLMraUhNfy7MHK5NUN?=
 =?us-ascii?Q?/EiTdcjf21+xxtllyhguQjzragMIif0IojSYuMVYb9z2H1/5L3W+6N+eSHrH?=
 =?us-ascii?Q?sUY7SxWcbuTs6ccoT55NV4GIYdwTL1Cu0I83CBIsDfEKGPbHc7anf3N0rHuO?=
 =?us-ascii?Q?tCIo43UdmulO195dHJQeLzqZFKIy2w+uF+xQaySOYzTtr2Q0726ul44iVBiU?=
 =?us-ascii?Q?/d6KdVz/4ZWRkvrOo/Puh1dogT8fvMctphdPyrtewezOCMWXFseQ37S56yhV?=
 =?us-ascii?Q?T1LuEw+m/kv7NRgD2aKCfAhDIO0T+iN4CbrlEsE6xd3RBbB31T/P/McM9LO4?=
 =?us-ascii?Q?YRtHlSV/ScdWm9bundOmWH4+fBxlLB9xZjLYwS4nu6Rq8BhdtW2rzsfRwGar?=
 =?us-ascii?Q?4oTeuwHKKzDotvWTu6ZVKAk5ZYZ7teXHFDcc0m70cyYEIzATlHr106tW8FBk?=
 =?us-ascii?Q?AGwLkcIyEDMJ4hxkpoROqTKbRh48a6DswjewjEnoKdnwRHiONGznvZawJmx5?=
 =?us-ascii?Q?HtYgSrHSnZP7HVqnyg2gYd+AyQdmIg4vSmPoNA9JLRAIRVX5yLKvJmgxbaR+?=
 =?us-ascii?Q?QodTGiJhCKX4sJOQ0eVRgZJbJw66wq2NfJawPfrweOKdpS0/UTEjzmwBekCE?=
 =?us-ascii?Q?QfwX1jfnXshw4MyKfXzEAzOFgX4mPw/lb9IIx0QUsjfvB7Wz8JlLvNH4Nn8b?=
 =?us-ascii?Q?7fQSA3Cg2OGa/MPfMenmWlwGsEJdFrV8NL8+0WJza7zOEcz6zTiy0IYCRwE/?=
 =?us-ascii?Q?Bctmy61tPjfcZhJuPm+dNKFl7Ywxiun6Hdn5OkBh5FhYrJOpfjUj8T9dvErd?=
 =?us-ascii?Q?HorNI4uKEMEk+x7MBxXJLnL/oYXVCkudErvxXvZKKn8B+Zfmhy9bhOjebQdf?=
 =?us-ascii?Q?A1h9jmview2aUXX9JbmFdm0tbqIbgDqgIGNvRtVru614CVOJeRsO13kICXLQ?=
 =?us-ascii?Q?tegl8ORlG1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cDPj7U4JdxfCiQHn6WPaqCPBfcu7jq162lXz61rGOkOElyQd3Me4gXccVbQG?=
 =?us-ascii?Q?lNN0ZswHI8KA4jGxE/59eEdj/iW9H2VT033pD8lY4WqtqVcemsq8FcqQUoHx?=
 =?us-ascii?Q?bXRe8pDaSzMccVxojG8GpTWT2B2x/w/qj/XoV2WX9kF1nwM7Ojya/IlFialG?=
 =?us-ascii?Q?uDJkHyw0jouuOIxesEo1snkRsFaNtu9ksU6kPgVg5uU0+OIJ8PXDpK0arlbM?=
 =?us-ascii?Q?iAuxQwu7D7SPiEHYWi9cHVzwPbuEzemswORer8a6iRnv0Ra4XB4FyyroBrlN?=
 =?us-ascii?Q?3+rFxkbJNZkE3ODROS3wB9cSx+EJgNwWEmq/YxdIFbmG7nwRcEZKK7djlWcY?=
 =?us-ascii?Q?0aVc8nfd0iRR/BWr8Eo7the0IpwvFUNlVjkJJGC/xZz9KvX8VAZjAAqB7ehZ?=
 =?us-ascii?Q?HoOKhdVfX8QUWRy1w+qZ50xKeVU0NcC49zKzaccAo6leWiXteReqmBEsBmNw?=
 =?us-ascii?Q?izVrAI5DMiVoh8FetyHMfxH1vSD17RffVqYtR4D0IdgE4ZZCffGJheBDHN1q?=
 =?us-ascii?Q?LSZan7oT0kWYgRYwS+j2AtrN8aIkCJHEAFhyQnwbAp7WSPTSmuN0q3GdpiTL?=
 =?us-ascii?Q?8Yh6Ga/DC2mVR5AO8EIh6OumkcAXQIVO0onGw/gPaYGwySYQv82tzXxDW4Yb?=
 =?us-ascii?Q?bz1i1HH2RlUvsQ3TC48YX5Jf0s/A2SfvOVAEuEc5+7Fl4cEsb/O8bWAfEabK?=
 =?us-ascii?Q?qp3j/iF0TEsGATUfFDSHVzi43CElJa/mDQ3wMMmwqumP1iobmcawez0tuxR7?=
 =?us-ascii?Q?V+nN1fdH6ejEWW/GrzIJfMKR6S5YHSM7LxXdB0ujd1XR69Zwb7VEIiImLukK?=
 =?us-ascii?Q?oYud3xc6PQst7ti/QnPTDa5lOq/SEMkGz4JUx75oZtlP9kef+B1yMCNd3WmN?=
 =?us-ascii?Q?+4Vjs4RKSZiA5UkNS+xemfcNd2FdyjAxwU20C9oQYCt/z9KP0eciSrQgc83T?=
 =?us-ascii?Q?w7IzwxUzKIxvDketAuU1uYwYAxkKp9HQpSQGUE4EiM9nokbuY6EeVMah25TG?=
 =?us-ascii?Q?4cHPSxfrEv7R+EG0ewSuPn2Xr9wLdLMu/3NlQH/gMZae+Fxy0I+2wzmwE4FC?=
 =?us-ascii?Q?SSa/BZTuGPVz2O8+fTOhqNbiHKwvpfvNrUd3WuTwMIW9IcGZHYUD3sc37c1V?=
 =?us-ascii?Q?q2EH9jm5Fba/8VYp37/8tC31ojkuXaD82mZNgHo+58A5RDwx1I4Sfgs87S2a?=
 =?us-ascii?Q?tMX+5unYagj+iquSBzaEOhafKw8506yfQn2RFOkUXLEOBFqjEJFh7FG4POMW?=
 =?us-ascii?Q?WAr9OSz42JTqnEwWG1yw+p+If5PnZB61iwlG8Cz8X3x4lTjKPM9Uo/3y3Z1e?=
 =?us-ascii?Q?V+s+4C2LI7J6BgbHyKR+Fry9uQu8t/p8q9QvoEk/2Le2feOxXUO1bdqd1H3g?=
 =?us-ascii?Q?LALzpNaXTHxlfb9JHT3GpuwGxU8e2suuvYButtDdyBprzo3QH/zvKMXIQmG7?=
 =?us-ascii?Q?6LAylnbYVk91vcN2HNyW8Ia8LARAIHdUM/LLx/WBXi/KEQCvoDMU8SrPMVHp?=
 =?us-ascii?Q?51HX0SxSB2+1BNYDmV5yJUIX3E5JwsI+QsBhDBEMD6JrDz6rHIP0r0nLdbvu?=
 =?us-ascii?Q?IrZlrpk17knxW9ic4bEejelQZePOO/XGl0/tM942u+vBVlG14HOgLqy86Em5?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	toQQwuqtu6LERfY8qaBdhX7+0VmTmJz8au3RiMvCngeTmTnvelEwGsR10UTEuuadXv0/rMtWUGwz3UVvXsgCqbjhY4/axluADREVydBSSa9dXgy7V5ss+IA7dKNtB62P3n9M1rgrsfi5rXbah/KqtsMJblgwBQ+/gQZUBz3c2OPdkzkbNte5GbhK6JwBRW6O0ckZvtNI4f8fRVE9qPucWcFsyyjHCw+jWygY6lW+hr6H0WuBakLBfh7IPzIbflxeKAHJq9uKsYix8cfq8+6BSPa0sbZIERI+2o8bsyeMLl3HBIPBuZ796WHAznlYVYmtlrHKz5RLXkV3Xk3/OqqHjEXYZGjnl4helfJZFrOqQYzogxuf9SgJnHmVNyFd+bxtI5P4MSYvccnnKUnuNr5e4dLBWi65Gd/Ukbff0F5Bv8WXLoEjXIjcJFf/OVbI4dSj2imAMjW97lm2uUlusR87jgSbqe/NiZAJoaINKCAZJzRwbI+DOl33wBrcuA4fIZgyEB9nirEOOs6dDXYo0Cq3JqLWwFIR4ZaKF0OjXRmgi1QweExpUjnpJPq4DBfCgUs68zu7jbIKrGII88FHz/dN5u523oQJqFCqVGIGuPe7OX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bca3d-16a7-4a62-178f-08dda4380553
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:51:07.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekiCFRkga1/x9TmzVW5NFQA1jXdhq0HpLfaVUxDdzUOrT1j0w6L/+wb+J7oA6wlo92grhGH3+A2Go8Lf6RfYXFQ/3CfD2mH8OGIF2MOreW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050118
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=6841a0d4 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=968KyxNXAAAA:8 a=1XWaLZrsAAAA:8 a=haWkGpQ1hhS-annS5p4A:9 cc=ntf awl=host:14714
X-Proofpoint-GUID: XKtUs2XxSQqTLYJdE2P9i52HIMG8q0jq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExOCBTYWx0ZWRfXxd0WXiEyiCSs 9iQJnILiHcVXtYGXBE48CJHZ7+sqYb/MlphPGAcgP4yDrFQseb3CEKReR4VNVCs242gN3dWozuR LQBEa2WoTdVymqT3mrx+IKaj+FBUh0J8FRUlMuMijtZiBoGahtPC0nEAu9jIJRYijW7XtGbrCV9
 KiT3ir3TTR3jy8/0Ba40ZYdgZIWXoe40TzEd0u8CDt3m6W+pF3FBgrmAv3Wt62ncQqe7VtJY7R+ ahv3niYpMUOM14VjWrIuiFKq+fLmOrcRJ9dez3bSBWsaqWGPALsiqloZf9Zcu4uC1o/xXxKwibZ /0ZQImKeLMhCSwJyr/3G60HnDmzsxzN3k5HhXekOKaRWS4TArxrWbe8bCK/R884a6anktPDJVtN
 HugdQk5i6DooZPfBqqW0t5aDQccPIyk+fKU3W2ypS2f9nujtnSMt+R8V2p4tFXtibXOZ3Kc+
X-Proofpoint-ORIG-GUID: XKtUs2XxSQqTLYJdE2P9i52HIMG8q0jq

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

The walk_page_range_debug() function is currently used to traverse both
userland and kernel mappings, so we maintain this and in the case of kernel
mappings being traversed, we have walk_page_range_debug() invoke
walk_kernel_page_table_range() internally.

We additionally make walk_page_range_debug() internal to mm.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
v3:
* Propagate tags (thanks everyone!)
* Drop __walk_page_range_vma(), not a huge issue to open code, as suggested
  by David.
* Some small whitespace adjustments.
* Fix erroneous reference to walk_page_range_novma() in the commit
  message as per Vlastimil.
* Reworde paragraph discussing walk_page_range_debug()'s invocation of
  walk_kernel_page_table_range() as per Vlastimil.

v2:
* Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
* Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
* Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
  per David.
https://lore.kernel.org/all/20250604141958.111300-1-lorenzo.stoakes@oracle.com/

v1 resend:
* Actually cc'd lists...
* Fixed mistake in walk_page_range_novma() not handling kernel mappings and
  update commit message to referene.
* Added Mike's off-list Acked-by.
* Fixed up comments as per Mike.
* Add some historic flavour to the commit message as per Mike.
https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/


 arch/loongarch/mm/pageattr.c |  2 +-
 arch/openrisc/kernel/dma.c   |  4 +-
 arch/riscv/mm/pageattr.c     |  8 ++--
 include/linux/pagewalk.h     |  7 ++--
 mm/hugetlb_vmemmap.c         |  2 +-
 mm/internal.h                |  3 ++
 mm/pagewalk.c                | 77 +++++++++++++++++++++++++-----------
 mm/ptdump.c                  |  3 +-
 8 files changed, 71 insertions(+), 35 deletions(-)

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
index 6b8ed2017743..71eaea2db9b0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1605,6 +1605,9 @@ static inline void accept_page(struct page *page)
 int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, const struct mm_walk_ops *ops,
+			  pgd_t *pgd, void *private);

 /* pt_reclaim.c */
 bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e478777c86e1..ff5299eca687 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -585,8 +585,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 }

 /**
- * walk_page_range_novma - walk a range of pagetables not backed by a vma
- * @mm:		mm_struct representing the target process of page table walk
+ * walk_kernel_page_table_range - walk a range of kernel pagetables.
  * @start:	start address of the virtual address range
  * @end:	end address of the virtual address range
  * @ops:	operation to call during the walk
@@ -596,17 +595,61 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
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
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= mm,
+		.pgd		= pgd,
+		.private	= private,
+		.no_vma		= true
+	};
+
+	if (start >= end)
+		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
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
+	return walk_pgd_range(start, end, &walk);
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
-			  pgd_t *pgd,
-			  void *private)
+			  pgd_t *pgd, void *private)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
@@ -616,34 +659,24 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		.no_vma		= true
 	};

+	/* For convenience, we allow traversal of kernel mappings. */
+	if (mm == &init_mm)
+		return walk_kernel_page_table_range(start, end, ops,
+						    pgd, private);
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 	if (!check_ops_valid(ops))
 		return -EINVAL;

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

 	return walk_pgd_range(start, end, &walk);
 }
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
