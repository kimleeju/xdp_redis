; ModuleID = 'af_xdp_kern.c'
source_filename = "af_xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.hdr_cursor = type { i8* }
%struct.collect_vlans = type { [2 x i16] }
%struct.vlan_hdr = type { i16, i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@xsks_map = dso_local global %struct.bpf_map_def { i32 17, i32 4, i32 4, i32 64, i32 0 }, section "maps", align 4, !dbg !52
@__const.xdp_sock_prog.____fmt = private unnamed_addr constant [24 x i8] c"----------------------\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !62
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_sock_prog to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_sock_prog(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_sock" !dbg !97 {
  %2 = alloca i32, align 4
  %3 = alloca [24 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !109, metadata !DIExpression()), !dbg !186
  %4 = bitcast i32* %2 to i8*, !dbg !187
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #3, !dbg !187
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 4, !dbg !188
  %6 = load i32, i32* %5, align 4, !dbg !188, !tbaa !189
  call void @llvm.dbg.value(metadata i32 %6, metadata !110, metadata !DIExpression()), !dbg !186
  store i32 %6, i32* %2, align 4, !dbg !194, !tbaa !195
  call void @llvm.dbg.value(metadata i32* %2, metadata !110, metadata !DIExpression(DW_OP_deref)), !dbg !186
  %7 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %4) #3, !dbg !196
  call void @llvm.dbg.value(metadata i8* %7, metadata !111, metadata !DIExpression()), !dbg !186
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !197
  %9 = load i32, i32* %8, align 4, !dbg !197, !tbaa !198
  %10 = zext i32 %9 to i64, !dbg !199
  %11 = inttoptr i64 %10 to i8*, !dbg !200
  call void @llvm.dbg.value(metadata i8* %11, metadata !170, metadata !DIExpression()), !dbg !186
  %12 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !201
  %13 = load i32, i32* %12, align 4, !dbg !201, !tbaa !202
  %14 = zext i32 %13 to i64, !dbg !203
  %15 = inttoptr i64 %14 to i8*, !dbg !204
  call void @llvm.dbg.value(metadata i8* %15, metadata !171, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i8* %15, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !115, metadata !DIExpression(DW_OP_deref)), !dbg !186
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !205, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata i8* %11, metadata !212, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !213, metadata !DIExpression()), !dbg !214
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !216, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i8* %11, metadata !228, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !229, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata %struct.collect_vlans* null, metadata !230, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i8* %15, metadata !231, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i32 14, metadata !232, metadata !DIExpression()), !dbg !241
  %16 = getelementptr i8, i8* %15, i64 14, !dbg !243
  %17 = icmp ugt i8* %16, %11, !dbg !245
  br i1 %17, label %81, label %18, !dbg !246

18:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %15, metadata !231, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i8* %16, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i8* %16, metadata !233, metadata !DIExpression()), !dbg !241
  %19 = getelementptr inbounds i8, i8* %15, i64 12, !dbg !247
  %20 = bitcast i8* %19 to i16*, !dbg !247
  call void @llvm.dbg.value(metadata i16 undef, metadata !239, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i32 0, metadata !240, metadata !DIExpression()), !dbg !241
  %21 = load i16, i16* %20, align 1, !dbg !241, !tbaa !248
  call void @llvm.dbg.value(metadata i16 %21, metadata !239, metadata !DIExpression()), !dbg !241
  %22 = inttoptr i64 %10 to %struct.vlan_hdr*, !dbg !250
  %23 = getelementptr i8, i8* %15, i64 22, !dbg !255
  %24 = bitcast i8* %23 to %struct.vlan_hdr*, !dbg !255
  switch i16 %21, label %39 [
    i16 -22392, label %25
    i16 129, label %25
  ], !dbg !256

25:                                               ; preds = %18, %18
  %26 = getelementptr i8, i8* %15, i64 18, !dbg !257
  %27 = bitcast i8* %26 to %struct.vlan_hdr*, !dbg !257
  %28 = icmp ugt %struct.vlan_hdr* %27, %22, !dbg !258
  br i1 %28, label %39, label %29, !dbg !259

29:                                               ; preds = %25
  call void @llvm.dbg.value(metadata i16 undef, metadata !239, metadata !DIExpression()), !dbg !241
  %30 = getelementptr i8, i8* %15, i64 16, !dbg !260
  %31 = bitcast i8* %30 to i16*, !dbg !260
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %27, metadata !233, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i32 1, metadata !240, metadata !DIExpression()), !dbg !241
  %32 = load i16, i16* %31, align 1, !dbg !241, !tbaa !248
  call void @llvm.dbg.value(metadata i16 %32, metadata !239, metadata !DIExpression()), !dbg !241
  switch i16 %32, label %39 [
    i16 -22392, label %33
    i16 129, label %33
  ], !dbg !256

33:                                               ; preds = %29, %29
  %34 = icmp ugt %struct.vlan_hdr* %24, %22, !dbg !258
  br i1 %34, label %39, label %35, !dbg !259

35:                                               ; preds = %33
  call void @llvm.dbg.value(metadata i16 undef, metadata !239, metadata !DIExpression()), !dbg !241
  %36 = getelementptr i8, i8* %15, i64 20, !dbg !260
  %37 = bitcast i8* %36 to i16*, !dbg !260
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %24, metadata !233, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i32 2, metadata !240, metadata !DIExpression()), !dbg !241
  %38 = load i16, i16* %37, align 1, !dbg !241, !tbaa !248
  call void @llvm.dbg.value(metadata i16 %38, metadata !239, metadata !DIExpression()), !dbg !241
  br label %39

39:                                               ; preds = %18, %25, %29, %33, %35
  %40 = phi i8* [ %16, %18 ], [ %16, %25 ], [ %26, %29 ], [ %26, %33 ], [ %23, %35 ], !dbg !241
  %41 = phi i16 [ %21, %18 ], [ %21, %25 ], [ %32, %29 ], [ %32, %33 ], [ %38, %35 ], !dbg !241
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !233, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !233, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !233, metadata !DIExpression()), !dbg !241
  call void @llvm.dbg.value(metadata i8* %40, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i8* %40, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i16 %41, metadata !113, metadata !DIExpression()), !dbg !186
  %42 = icmp ne i16 %41, 8, !dbg !261
  %43 = getelementptr inbounds i8, i8* %40, i64 20, !dbg !263
  %44 = icmp ugt i8* %43, %11, !dbg !277
  %45 = or i1 %42, %44, !dbg !278
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !129, metadata !DIExpression(DW_OP_deref)), !dbg !186
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !270, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.value(metadata i8* %11, metadata !271, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !272, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.value(metadata i8* %40, metadata !273, metadata !DIExpression()), !dbg !279
  br i1 %45, label %81, label %46, !dbg !278

46:                                               ; preds = %39
  %47 = load i8, i8* %40, align 4, !dbg !280
  %48 = shl i8 %47, 2, !dbg !281
  %49 = and i8 %48, 60, !dbg !281
  call void @llvm.dbg.value(metadata i8 %49, metadata !274, metadata !DIExpression()), !dbg !279
  %50 = icmp ult i8 %49, 20, !dbg !282
  br i1 %50, label %81, label %51, !dbg !284

51:                                               ; preds = %46
  %52 = zext i8 %49 to i64, !dbg !285
  call void @llvm.dbg.value(metadata i64 %52, metadata !274, metadata !DIExpression()), !dbg !279
  %53 = getelementptr i8, i8* %40, i64 %52, !dbg !286
  %54 = icmp ugt i8* %53, %11, !dbg !288
  br i1 %54, label %81, label %55, !dbg !289

55:                                               ; preds = %51
  call void @llvm.dbg.value(metadata i8* %53, metadata !172, metadata !DIExpression()), !dbg !186
  %56 = getelementptr inbounds i8, i8* %40, i64 9, !dbg !290
  %57 = load i8, i8* %56, align 1, !dbg !290, !tbaa !291
  call void @llvm.dbg.value(metadata i8* %53, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i8 %57, metadata !114, metadata !DIExpression()), !dbg !186
  %58 = icmp ne i8 %57, 6, !dbg !293
  %59 = getelementptr inbounds i8, i8* %53, i64 20, !dbg !294
  %60 = icmp ugt i8* %59, %11, !dbg !308
  %61 = or i1 %60, %58, !dbg !309
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !301, metadata !DIExpression()), !dbg !310
  call void @llvm.dbg.value(metadata i8* %11, metadata !302, metadata !DIExpression()), !dbg !310
  call void @llvm.dbg.value(metadata i8* %53, metadata !305, metadata !DIExpression()), !dbg !310
  br i1 %61, label %81, label %62, !dbg !309

62:                                               ; preds = %55
  %63 = getelementptr inbounds i8, i8* %53, i64 12, !dbg !311
  %64 = bitcast i8* %63 to i16*, !dbg !311
  %65 = load i16, i16* %64, align 4, !dbg !311
  %66 = lshr i16 %65, 2, !dbg !312
  %67 = and i16 %66, 60, !dbg !312
  call void @llvm.dbg.value(metadata i16 %67, metadata !304, metadata !DIExpression()), !dbg !310
  %68 = icmp ult i16 %67, 20, !dbg !313
  br i1 %68, label %81, label %69, !dbg !315

69:                                               ; preds = %62
  %70 = zext i16 %67 to i64, !dbg !316
  %71 = getelementptr i8, i8* %53, i64 %70, !dbg !317
  %72 = icmp ugt i8* %71, %11, !dbg !319
  %73 = and i16 %65, 2048, !dbg !320
  %74 = icmp eq i16 %73, 0, !dbg !321
  %75 = or i1 %72, %74, !dbg !322
  call void @llvm.dbg.value(metadata i8* %71, metadata !172, metadata !DIExpression()), !dbg !186
  call void @llvm.dbg.value(metadata i8* %53, metadata !148, metadata !DIExpression()), !dbg !186
  br i1 %75, label %81, label %76, !dbg !322

76:                                               ; preds = %69
  %77 = getelementptr inbounds [24 x i8], [24 x i8]* %3, i64 0, i64 0, !dbg !323
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %77) #3, !dbg !323
  call void @llvm.dbg.declare(metadata [24 x i8]* %3, metadata !177, metadata !DIExpression()), !dbg !323
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(24) %77, i8* nonnull align 1 dereferenceable(24) getelementptr inbounds ([24 x i8], [24 x i8]* @__const.xdp_sock_prog.____fmt, i64 0, i64 0), i64 24, i1 false), !dbg !323
  %78 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %77, i32 24) #3, !dbg !323
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %77) #3, !dbg !324
  %79 = load i32, i32* %2, align 4, !dbg !325, !tbaa !195
  call void @llvm.dbg.value(metadata i32 %79, metadata !110, metadata !DIExpression()), !dbg !186
  %80 = call i32 inttoptr (i64 51 to i32 (i8*, i32, i64)*)(i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*), i32 %79, i64 0) #3, !dbg !326
  br label %81, !dbg !327

81:                                               ; preds = %55, %39, %69, %62, %51, %46, %1, %76
  %82 = phi i32 [ %80, %76 ], [ 2, %39 ], [ 2, %55 ], [ 2, %1 ], [ 2, %46 ], [ 2, %51 ], [ 2, %62 ], [ 2, %69 ], !dbg !186
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #3, !dbg !328
  ret i32 %82, !dbg !328
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!93, !94, !95}
!llvm.ident = !{!96}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !92, line: 18, type: !54, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !45, globals: !51, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "af_xdp_kern.c", directory: "/home/ljkim/xdp/xdp_redis/src")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 28, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/linux/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!43 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262, isUnsigned: true)
!44 = !DIEnumerator(name: "IPPROTO_MAX", value: 263, isUnsigned: true)
!45 = !{!46, !47, !48}
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!47 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !49, line: 24, baseType: !50)
!49 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!50 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!51 = !{!0, !52, !62, !68, !76, !85}
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 18, type: !54, isLocal: false, isDefinition: true)
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !55, line: 33, size: 160, elements: !56)
!55 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!56 = !{!57, !58, !59, !60, !61}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !54, file: !55, line: 34, baseType: !7, size: 32)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !54, file: !55, line: 35, baseType: !7, size: 32, offset: 32)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !54, file: !55, line: 36, baseType: !7, size: 32, offset: 64)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !54, file: !55, line: 37, baseType: !7, size: 32, offset: 96)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !54, file: !55, line: 38, baseType: !7, size: 32, offset: 128)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 169, type: !64, isLocal: false, isDefinition: true)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !65, size: 32, elements: !66)
!65 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!66 = !{!67}
!67 = !DISubrange(count: 4)
!68 = !DIGlobalVariableExpression(var: !69, expr: !DIExpression())
!69 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !70, line: 33, type: !71, isLocal: true, isDefinition: true)
!70 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DISubroutineType(types: !73)
!73 = !{!46, !46, !74}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !70, line: 152, type: !78, isLocal: true, isDefinition: true)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 64)
!79 = !DISubroutineType(types: !80)
!80 = !{!81, !82, !84, null}
!81 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !65)
!84 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !49, line: 27, baseType: !7)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !70, line: 1254, type: !87, isLocal: true, isDefinition: true)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!88 = !DISubroutineType(types: !89)
!89 = !{!81, !46, !84, !90}
!90 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !49, line: 31, baseType: !91)
!91 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!92 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!93 = !{i32 7, !"Dwarf Version", i32 4}
!94 = !{i32 2, !"Debug Info Version", i32 3}
!95 = !{i32 1, !"wchar_size", i32 4}
!96 = !{!"clang version 10.0.0-4ubuntu1 "}
!97 = distinct !DISubprogram(name: "xdp_sock_prog", scope: !3, file: !3, line: 26, type: !98, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !108)
!98 = !DISubroutineType(types: !99)
!99 = !{!81, !100}
!100 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !101, size: 64)
!101 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !102)
!102 = !{!103, !104, !105, !106, !107}
!103 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !101, file: !6, line: 2857, baseType: !84, size: 32)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !101, file: !6, line: 2858, baseType: !84, size: 32, offset: 32)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !101, file: !6, line: 2859, baseType: !84, size: 32, offset: 64)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !101, file: !6, line: 2861, baseType: !84, size: 32, offset: 96)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !101, file: !6, line: 2862, baseType: !84, size: 32, offset: 128)
!108 = !{!109, !110, !111, !113, !114, !115, !129, !148, !170, !171, !172, !177}
!109 = !DILocalVariable(name: "ctx", arg: 1, scope: !97, file: !3, line: 26, type: !100)
!110 = !DILocalVariable(name: "index", scope: !97, file: !3, line: 28, type: !81)
!111 = !DILocalVariable(name: "pkt_count", scope: !97, file: !3, line: 31, type: !112)
!112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!113 = !DILocalVariable(name: "eth_type", scope: !97, file: !3, line: 44, type: !81)
!114 = !DILocalVariable(name: "ip_type", scope: !97, file: !3, line: 44, type: !81)
!115 = !DILocalVariable(name: "eth", scope: !97, file: !3, line: 45, type: !116)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !118, line: 168, size: 112, elements: !119)
!118 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!119 = !{!120, !125, !126}
!120 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !117, file: !118, line: 169, baseType: !121, size: 48)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !122, size: 48, elements: !123)
!122 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!123 = !{!124}
!124 = !DISubrange(count: 6)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !117, file: !118, line: 170, baseType: !121, size: 48, offset: 48)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !117, file: !118, line: 171, baseType: !127, size: 16, offset: 96)
!127 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !128, line: 25, baseType: !48)
!128 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!129 = !DILocalVariable(name: "iphdr", scope: !97, file: !3, line: 46, type: !130)
!130 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !131, size: 64)
!131 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !132, line: 86, size: 160, elements: !133)
!132 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!133 = !{!134, !136, !137, !138, !139, !140, !141, !142, !143, !145, !147}
!134 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !131, file: !132, line: 88, baseType: !135, size: 4, flags: DIFlagBitField, extraData: i64 0)
!135 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !49, line: 21, baseType: !122)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !131, file: !132, line: 89, baseType: !135, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !131, file: !132, line: 96, baseType: !135, size: 8, offset: 8)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !131, file: !132, line: 97, baseType: !127, size: 16, offset: 16)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !131, file: !132, line: 98, baseType: !127, size: 16, offset: 32)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !131, file: !132, line: 99, baseType: !127, size: 16, offset: 48)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !131, file: !132, line: 100, baseType: !135, size: 8, offset: 64)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !131, file: !132, line: 101, baseType: !135, size: 8, offset: 72)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !131, file: !132, line: 102, baseType: !144, size: 16, offset: 80)
!144 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !128, line: 31, baseType: !48)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !131, file: !132, line: 103, baseType: !146, size: 32, offset: 96)
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !128, line: 27, baseType: !84)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !131, file: !132, line: 104, baseType: !146, size: 32, offset: 128)
!148 = !DILocalVariable(name: "tcphdr", scope: !97, file: !3, line: 47, type: !149)
!149 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!150 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !151, line: 25, size: 160, elements: !152)
!151 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!152 = !{!153, !154, !155, !156, !157, !158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169}
!153 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !150, file: !151, line: 26, baseType: !127, size: 16)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !150, file: !151, line: 27, baseType: !127, size: 16, offset: 16)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !150, file: !151, line: 28, baseType: !146, size: 32, offset: 32)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !150, file: !151, line: 29, baseType: !146, size: 32, offset: 64)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !150, file: !151, line: 31, baseType: !48, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !150, file: !151, line: 32, baseType: !48, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !150, file: !151, line: 33, baseType: !48, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !150, file: !151, line: 34, baseType: !48, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !150, file: !151, line: 35, baseType: !48, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !150, file: !151, line: 36, baseType: !48, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !150, file: !151, line: 37, baseType: !48, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !150, file: !151, line: 38, baseType: !48, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !150, file: !151, line: 39, baseType: !48, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !150, file: !151, line: 40, baseType: !48, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !150, file: !151, line: 55, baseType: !127, size: 16, offset: 112)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !150, file: !151, line: 56, baseType: !144, size: 16, offset: 128)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !150, file: !151, line: 57, baseType: !127, size: 16, offset: 144)
!170 = !DILocalVariable(name: "data_end", scope: !97, file: !3, line: 48, type: !46)
!171 = !DILocalVariable(name: "data", scope: !97, file: !3, line: 49, type: !46)
!172 = !DILocalVariable(name: "nh", scope: !97, file: !3, line: 50, type: !173)
!173 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !174, line: 33, size: 64, elements: !175)
!174 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!175 = !{!176}
!176 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !173, file: !174, line: 34, baseType: !46, size: 64)
!177 = !DILocalVariable(name: "____fmt", scope: !178, file: !3, line: 82, type: !183)
!178 = distinct !DILexicalBlock(scope: !179, file: !3, line: 82, column: 13)
!179 = distinct !DILexicalBlock(scope: !180, file: !3, line: 70, column: 24)
!180 = distinct !DILexicalBlock(scope: !181, file: !3, line: 70, column: 12)
!181 = distinct !DILexicalBlock(scope: !182, file: !3, line: 64, column: 33)
!182 = distinct !DILexicalBlock(scope: !97, file: !3, line: 64, column: 9)
!183 = !DICompositeType(tag: DW_TAG_array_type, baseType: !65, size: 192, elements: !184)
!184 = !{!185}
!185 = !DISubrange(count: 24)
!186 = !DILocation(line: 0, scope: !97)
!187 = !DILocation(line: 28, column: 5, scope: !97)
!188 = !DILocation(line: 28, column: 22, scope: !97)
!189 = !{!190, !191, i64 16}
!190 = !{!"xdp_md", !191, i64 0, !191, i64 4, !191, i64 8, !191, i64 12, !191, i64 16}
!191 = !{!"int", !192, i64 0}
!192 = !{!"omnipotent char", !193, i64 0}
!193 = !{!"Simple C/C++ TBAA"}
!194 = !DILocation(line: 28, column: 9, scope: !97)
!195 = !{!191, !191, i64 0}
!196 = !DILocation(line: 33, column: 17, scope: !97)
!197 = !DILocation(line: 48, column: 41, scope: !97)
!198 = !{!190, !191, i64 4}
!199 = !DILocation(line: 48, column: 30, scope: !97)
!200 = !DILocation(line: 48, column: 22, scope: !97)
!201 = !DILocation(line: 49, column: 37, scope: !97)
!202 = !{!190, !191, i64 0}
!203 = !DILocation(line: 49, column: 26, scope: !97)
!204 = !DILocation(line: 49, column: 18, scope: !97)
!205 = !DILocalVariable(name: "nh", arg: 1, scope: !206, file: !174, line: 124, type: !209)
!206 = distinct !DISubprogram(name: "parse_ethhdr", scope: !174, file: !174, line: 124, type: !207, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !211)
!207 = !DISubroutineType(types: !208)
!208 = !{!81, !209, !46, !210}
!209 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !173, size: 64)
!210 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !116, size: 64)
!211 = !{!205, !212, !213}
!212 = !DILocalVariable(name: "data_end", arg: 2, scope: !206, file: !174, line: 125, type: !46)
!213 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !206, file: !174, line: 126, type: !210)
!214 = !DILocation(line: 0, scope: !206, inlinedAt: !215)
!215 = distinct !DILocation(line: 51, column: 16, scope: !97)
!216 = !DILocalVariable(name: "nh", arg: 1, scope: !217, file: !174, line: 79, type: !209)
!217 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !174, file: !174, line: 79, type: !218, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !227)
!218 = !DISubroutineType(types: !219)
!219 = !{!81, !209, !46, !210, !220}
!220 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !221, size: 64)
!221 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !174, line: 64, size: 32, elements: !222)
!222 = !{!223}
!223 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !221, file: !174, line: 65, baseType: !224, size: 32)
!224 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 32, elements: !225)
!225 = !{!226}
!226 = !DISubrange(count: 2)
!227 = !{!216, !228, !229, !230, !231, !232, !233, !239, !240}
!228 = !DILocalVariable(name: "data_end", arg: 2, scope: !217, file: !174, line: 80, type: !46)
!229 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !217, file: !174, line: 81, type: !210)
!230 = !DILocalVariable(name: "vlans", arg: 4, scope: !217, file: !174, line: 82, type: !220)
!231 = !DILocalVariable(name: "eth", scope: !217, file: !174, line: 84, type: !116)
!232 = !DILocalVariable(name: "hdrsize", scope: !217, file: !174, line: 85, type: !81)
!233 = !DILocalVariable(name: "vlh", scope: !217, file: !174, line: 86, type: !234)
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!235 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !174, line: 42, size: 32, elements: !236)
!236 = !{!237, !238}
!237 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !235, file: !174, line: 43, baseType: !127, size: 16)
!238 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !235, file: !174, line: 44, baseType: !127, size: 16, offset: 16)
!239 = !DILocalVariable(name: "h_proto", scope: !217, file: !174, line: 87, type: !48)
!240 = !DILocalVariable(name: "i", scope: !217, file: !174, line: 88, type: !81)
!241 = !DILocation(line: 0, scope: !217, inlinedAt: !242)
!242 = distinct !DILocation(line: 129, column: 9, scope: !206, inlinedAt: !215)
!243 = !DILocation(line: 93, column: 14, scope: !244, inlinedAt: !242)
!244 = distinct !DILexicalBlock(scope: !217, file: !174, line: 93, column: 6)
!245 = !DILocation(line: 93, column: 24, scope: !244, inlinedAt: !242)
!246 = !DILocation(line: 93, column: 6, scope: !217, inlinedAt: !242)
!247 = !DILocation(line: 99, column: 17, scope: !217, inlinedAt: !242)
!248 = !{!249, !249, i64 0}
!249 = !{!"short", !192, i64 0}
!250 = !DILocation(line: 0, scope: !251, inlinedAt: !242)
!251 = distinct !DILexicalBlock(scope: !252, file: !174, line: 109, column: 7)
!252 = distinct !DILexicalBlock(scope: !253, file: !174, line: 105, column: 39)
!253 = distinct !DILexicalBlock(scope: !254, file: !174, line: 105, column: 2)
!254 = distinct !DILexicalBlock(scope: !217, file: !174, line: 105, column: 2)
!255 = !DILocation(line: 105, column: 2, scope: !254, inlinedAt: !242)
!256 = !DILocation(line: 106, column: 7, scope: !252, inlinedAt: !242)
!257 = !DILocation(line: 109, column: 11, scope: !251, inlinedAt: !242)
!258 = !DILocation(line: 109, column: 15, scope: !251, inlinedAt: !242)
!259 = !DILocation(line: 109, column: 7, scope: !252, inlinedAt: !242)
!260 = !DILocation(line: 112, column: 18, scope: !252, inlinedAt: !242)
!261 = !DILocation(line: 57, column: 18, scope: !262)
!262 = distinct !DILexicalBlock(scope: !97, file: !3, line: 57, column: 9)
!263 = !DILocation(line: 158, column: 10, scope: !264, inlinedAt: !275)
!264 = distinct !DILexicalBlock(scope: !265, file: !174, line: 158, column: 6)
!265 = distinct !DISubprogram(name: "parse_iphdr", scope: !174, file: !174, line: 151, type: !266, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !269)
!266 = !DISubroutineType(types: !267)
!267 = !{!81, !209, !46, !268}
!268 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !130, size: 64)
!269 = !{!270, !271, !272, !273, !274}
!270 = !DILocalVariable(name: "nh", arg: 1, scope: !265, file: !174, line: 151, type: !209)
!271 = !DILocalVariable(name: "data_end", arg: 2, scope: !265, file: !174, line: 152, type: !46)
!272 = !DILocalVariable(name: "iphdr", arg: 3, scope: !265, file: !174, line: 153, type: !268)
!273 = !DILocalVariable(name: "iph", scope: !265, file: !174, line: 155, type: !130)
!274 = !DILocalVariable(name: "hdrsize", scope: !265, file: !174, line: 156, type: !81)
!275 = distinct !DILocation(line: 58, column: 19, scope: !276)
!276 = distinct !DILexicalBlock(scope: !262, file: !3, line: 57, column: 42)
!277 = !DILocation(line: 158, column: 14, scope: !264, inlinedAt: !275)
!278 = !DILocation(line: 53, column: 9, scope: !97)
!279 = !DILocation(line: 0, scope: !265, inlinedAt: !275)
!280 = !DILocation(line: 161, column: 17, scope: !265, inlinedAt: !275)
!281 = !DILocation(line: 161, column: 21, scope: !265, inlinedAt: !275)
!282 = !DILocation(line: 163, column: 13, scope: !283, inlinedAt: !275)
!283 = distinct !DILexicalBlock(scope: !265, file: !174, line: 163, column: 5)
!284 = !DILocation(line: 163, column: 5, scope: !265, inlinedAt: !275)
!285 = !DILocation(line: 163, column: 5, scope: !283, inlinedAt: !275)
!286 = !DILocation(line: 167, column: 14, scope: !287, inlinedAt: !275)
!287 = distinct !DILexicalBlock(scope: !265, file: !174, line: 167, column: 6)
!288 = !DILocation(line: 167, column: 24, scope: !287, inlinedAt: !275)
!289 = !DILocation(line: 167, column: 6, scope: !265, inlinedAt: !275)
!290 = !DILocation(line: 173, column: 14, scope: !265, inlinedAt: !275)
!291 = !{!292, !192, i64 9}
!292 = !{!"iphdr", !192, i64 0, !192, i64 0, !192, i64 1, !249, i64 2, !249, i64 4, !249, i64 6, !192, i64 8, !192, i64 9, !249, i64 10, !191, i64 12, !191, i64 16}
!293 = !DILocation(line: 64, column: 17, scope: !182)
!294 = !DILocation(line: 254, column: 8, scope: !295, inlinedAt: !306)
!295 = distinct !DILexicalBlock(scope: !296, file: !174, line: 254, column: 6)
!296 = distinct !DISubprogram(name: "parse_tcphdr", scope: !174, file: !174, line: 247, type: !297, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !300)
!297 = !DISubroutineType(types: !298)
!298 = !{!81, !209, !46, !299}
!299 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !149, size: 64)
!300 = !{!301, !302, !303, !304, !305}
!301 = !DILocalVariable(name: "nh", arg: 1, scope: !296, file: !174, line: 247, type: !209)
!302 = !DILocalVariable(name: "data_end", arg: 2, scope: !296, file: !174, line: 248, type: !46)
!303 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !296, file: !174, line: 249, type: !299)
!304 = !DILocalVariable(name: "len", scope: !296, file: !174, line: 251, type: !81)
!305 = !DILocalVariable(name: "h", scope: !296, file: !174, line: 252, type: !149)
!306 = distinct !DILocation(line: 66, column: 13, scope: !307)
!307 = distinct !DILexicalBlock(scope: !181, file: !3, line: 66, column: 13)
!308 = !DILocation(line: 254, column: 12, scope: !295, inlinedAt: !306)
!309 = !DILocation(line: 64, column: 9, scope: !97)
!310 = !DILocation(line: 0, scope: !296, inlinedAt: !306)
!311 = !DILocation(line: 257, column: 11, scope: !296, inlinedAt: !306)
!312 = !DILocation(line: 257, column: 16, scope: !296, inlinedAt: !306)
!313 = !DILocation(line: 259, column: 9, scope: !314, inlinedAt: !306)
!314 = distinct !DILexicalBlock(scope: !296, file: !174, line: 259, column: 5)
!315 = !DILocation(line: 259, column: 5, scope: !296, inlinedAt: !306)
!316 = !DILocation(line: 259, column: 5, scope: !314, inlinedAt: !306)
!317 = !DILocation(line: 263, column: 14, scope: !318, inlinedAt: !306)
!318 = distinct !DILexicalBlock(scope: !296, file: !174, line: 263, column: 6)
!319 = !DILocation(line: 263, column: 20, scope: !318, inlinedAt: !306)
!320 = !DILocation(line: 70, column: 20, scope: !180)
!321 = !DILocation(line: 70, column: 12, scope: !180)
!322 = !DILocation(line: 263, column: 6, scope: !296, inlinedAt: !306)
!323 = !DILocation(line: 82, column: 13, scope: !178)
!324 = !DILocation(line: 82, column: 13, scope: !179)
!325 = !DILocation(line: 84, column: 48, scope: !179)
!326 = !DILocation(line: 84, column: 20, scope: !179)
!327 = !DILocation(line: 84, column: 13, scope: !179)
!328 = !DILocation(line: 152, column: 1, scope: !97)
