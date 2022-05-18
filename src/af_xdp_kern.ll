; ModuleID = 'af_xdp_kern.c'
source_filename = "af_xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.hdr_cursor = type { i8* }
%struct.collect_vlans = type { [2 x i16] }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.vlan_hdr = type { i16, i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }

@sdsmvtonvm = dso_local local_unnamed_addr global i8 (i8*)* inttoptr (i64 116 to i8 (i8*)*), align 8, !dbg !0
@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !52
@xsks_map = dso_local global %struct.bpf_map_def { i32 17, i32 4, i32 4, i32 64, i32 0 }, section "maps", align 4, !dbg !63
@__const.xdp_sock_prog.____fmt = private unnamed_addr constant [21 x i8] c"1111111111111111111\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !65
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_sock_prog to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_sock_prog(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_sock" !dbg !102 {
  %2 = alloca i32, align 4
  %3 = alloca [21 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !114, metadata !DIExpression()), !dbg !191
  %4 = bitcast i32* %2 to i8*, !dbg !192
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #3, !dbg !192
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 4, !dbg !193
  %6 = load i32, i32* %5, align 4, !dbg !193, !tbaa !194
  call void @llvm.dbg.value(metadata i32 %6, metadata !115, metadata !DIExpression()), !dbg !191
  store i32 %6, i32* %2, align 4, !dbg !199, !tbaa !200
  call void @llvm.dbg.value(metadata i32* %2, metadata !115, metadata !DIExpression(DW_OP_deref)), !dbg !191
  %7 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %4) #3, !dbg !201
  call void @llvm.dbg.value(metadata i8* %7, metadata !116, metadata !DIExpression()), !dbg !191
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !202
  %9 = load i32, i32* %8, align 4, !dbg !202, !tbaa !203
  %10 = zext i32 %9 to i64, !dbg !204
  %11 = inttoptr i64 %10 to i8*, !dbg !205
  call void @llvm.dbg.value(metadata i8* %11, metadata !175, metadata !DIExpression()), !dbg !191
  %12 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !206
  %13 = load i32, i32* %12, align 4, !dbg !206, !tbaa !207
  %14 = zext i32 %13 to i64, !dbg !208
  %15 = inttoptr i64 %14 to i8*, !dbg !209
  call void @llvm.dbg.value(metadata i8* %15, metadata !176, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata i8* %15, metadata !177, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !210, metadata !DIExpression()), !dbg !219
  call void @llvm.dbg.value(metadata i8* %11, metadata !217, metadata !DIExpression()), !dbg !219
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !221, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %11, metadata !233, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata %struct.collect_vlans* null, metadata !235, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %15, metadata !236, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 14, metadata !237, metadata !DIExpression()), !dbg !246
  %16 = getelementptr i8, i8* %15, i64 14, !dbg !248
  %17 = icmp ugt i8* %16, %11, !dbg !250
  br i1 %17, label %85, label %18, !dbg !251

18:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %15, metadata !236, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %16, metadata !177, metadata !DIExpression()), !dbg !191
  %19 = inttoptr i64 %14 to %struct.ethhdr*, !dbg !252
  call void @llvm.dbg.value(metadata i8* %16, metadata !238, metadata !DIExpression()), !dbg !246
  %20 = getelementptr inbounds i8, i8* %15, i64 12, !dbg !253
  %21 = bitcast i8* %20 to i16*, !dbg !253
  call void @llvm.dbg.value(metadata i16 undef, metadata !244, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 0, metadata !245, metadata !DIExpression()), !dbg !246
  %22 = load i16, i16* %21, align 1, !dbg !246, !tbaa !254
  call void @llvm.dbg.value(metadata i16 %22, metadata !244, metadata !DIExpression()), !dbg !246
  %23 = inttoptr i64 %10 to %struct.vlan_hdr*, !dbg !256
  %24 = getelementptr i8, i8* %15, i64 22, !dbg !261
  %25 = bitcast i8* %24 to %struct.vlan_hdr*, !dbg !261
  switch i16 %22, label %40 [
    i16 -22392, label %26
    i16 129, label %26
  ], !dbg !262

26:                                               ; preds = %18, %18
  %27 = getelementptr i8, i8* %15, i64 18, !dbg !263
  %28 = bitcast i8* %27 to %struct.vlan_hdr*, !dbg !263
  %29 = icmp ugt %struct.vlan_hdr* %28, %23, !dbg !264
  br i1 %29, label %40, label %30, !dbg !265

30:                                               ; preds = %26
  call void @llvm.dbg.value(metadata i16 undef, metadata !244, metadata !DIExpression()), !dbg !246
  %31 = getelementptr i8, i8* %15, i64 16, !dbg !266
  %32 = bitcast i8* %31 to i16*, !dbg !266
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %28, metadata !238, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 1, metadata !245, metadata !DIExpression()), !dbg !246
  %33 = load i16, i16* %32, align 1, !dbg !246, !tbaa !254
  call void @llvm.dbg.value(metadata i16 %33, metadata !244, metadata !DIExpression()), !dbg !246
  switch i16 %33, label %40 [
    i16 -22392, label %34
    i16 129, label %34
  ], !dbg !262

34:                                               ; preds = %30, %30
  %35 = icmp ugt %struct.vlan_hdr* %25, %23, !dbg !264
  br i1 %35, label %40, label %36, !dbg !265

36:                                               ; preds = %34
  call void @llvm.dbg.value(metadata i16 undef, metadata !244, metadata !DIExpression()), !dbg !246
  %37 = getelementptr i8, i8* %15, i64 20, !dbg !266
  %38 = bitcast i8* %37 to i16*, !dbg !266
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %25, metadata !238, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 2, metadata !245, metadata !DIExpression()), !dbg !246
  %39 = load i16, i16* %38, align 1, !dbg !246, !tbaa !254
  call void @llvm.dbg.value(metadata i16 %39, metadata !244, metadata !DIExpression()), !dbg !246
  br label %40

40:                                               ; preds = %18, %26, %30, %34, %36
  %41 = phi i8* [ %16, %18 ], [ %16, %26 ], [ %27, %30 ], [ %27, %34 ], [ %24, %36 ], !dbg !246
  %42 = phi i16 [ %22, %18 ], [ %22, %26 ], [ %33, %30 ], [ %33, %34 ], [ %39, %36 ], !dbg !246
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !238, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !238, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !238, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %41, metadata !177, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata i8* %41, metadata !177, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata i16 %42, metadata !118, metadata !DIExpression()), !dbg !191
  %43 = icmp ne i16 %42, 8, !dbg !267
  %44 = getelementptr inbounds i8, i8* %41, i64 20, !dbg !269
  %45 = icmp ugt i8* %44, %11, !dbg !283
  %46 = or i1 %43, %45, !dbg !284
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !134, metadata !DIExpression(DW_OP_deref)), !dbg !191
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !276, metadata !DIExpression()), !dbg !285
  call void @llvm.dbg.value(metadata i8* %11, metadata !277, metadata !DIExpression()), !dbg !285
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !278, metadata !DIExpression()), !dbg !285
  call void @llvm.dbg.value(metadata i8* %41, metadata !279, metadata !DIExpression()), !dbg !285
  br i1 %46, label %85, label %47, !dbg !284

47:                                               ; preds = %40
  %48 = load i8, i8* %41, align 4, !dbg !286
  %49 = shl i8 %48, 2, !dbg !287
  %50 = and i8 %49, 60, !dbg !287
  call void @llvm.dbg.value(metadata i8 %50, metadata !280, metadata !DIExpression()), !dbg !285
  %51 = icmp ult i8 %50, 20, !dbg !288
  br i1 %51, label %85, label %52, !dbg !290

52:                                               ; preds = %47
  %53 = zext i8 %50 to i64, !dbg !291
  call void @llvm.dbg.value(metadata i64 %53, metadata !280, metadata !DIExpression()), !dbg !285
  %54 = getelementptr i8, i8* %41, i64 %53, !dbg !292
  %55 = icmp ugt i8* %54, %11, !dbg !294
  br i1 %55, label %85, label %56, !dbg !295

56:                                               ; preds = %52
  call void @llvm.dbg.value(metadata i8* %54, metadata !177, metadata !DIExpression()), !dbg !191
  %57 = getelementptr inbounds i8, i8* %41, i64 9, !dbg !296
  %58 = load i8, i8* %57, align 1, !dbg !296, !tbaa !297
  call void @llvm.dbg.value(metadata i8* %54, metadata !177, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata i8 %58, metadata !119, metadata !DIExpression()), !dbg !191
  %59 = icmp ne i8 %58, 6, !dbg !299
  %60 = getelementptr inbounds i8, i8* %54, i64 20, !dbg !300
  %61 = icmp ugt i8* %60, %11, !dbg !314
  %62 = or i1 %61, %59, !dbg !315
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !307, metadata !DIExpression()), !dbg !316
  call void @llvm.dbg.value(metadata i8* %11, metadata !308, metadata !DIExpression()), !dbg !316
  call void @llvm.dbg.value(metadata i8* %54, metadata !311, metadata !DIExpression()), !dbg !316
  br i1 %62, label %85, label %63, !dbg !315

63:                                               ; preds = %56
  %64 = getelementptr inbounds i8, i8* %54, i64 12, !dbg !317
  %65 = bitcast i8* %64 to i16*, !dbg !317
  %66 = load i16, i16* %65, align 4, !dbg !317
  %67 = lshr i16 %66, 2, !dbg !318
  %68 = and i16 %67, 60, !dbg !318
  call void @llvm.dbg.value(metadata i16 %68, metadata !310, metadata !DIExpression()), !dbg !316
  %69 = icmp ult i16 %68, 20, !dbg !319
  br i1 %69, label %85, label %70, !dbg !321

70:                                               ; preds = %63
  %71 = zext i16 %68 to i64, !dbg !322
  %72 = getelementptr i8, i8* %54, i64 %71, !dbg !323
  %73 = icmp ugt i8* %72, %11, !dbg !325
  %74 = and i16 %66, 2048, !dbg !326
  %75 = icmp eq i16 %74, 0, !dbg !327
  %76 = or i1 %73, %75, !dbg !328
  call void @llvm.dbg.value(metadata i8* %72, metadata !177, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata i8* %54, metadata !153, metadata !DIExpression()), !dbg !191
  br i1 %76, label %85, label %77, !dbg !328

77:                                               ; preds = %70
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !120, metadata !DIExpression()), !dbg !191
  %78 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 7, i32 0, i64 0, !dbg !329
  %79 = icmp ugt i8* %78, %11, !dbg !331
  br i1 %79, label %85, label %80, !dbg !332

80:                                               ; preds = %77
  %81 = getelementptr inbounds [21 x i8], [21 x i8]* %3, i64 0, i64 0, !dbg !333
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %81) #3, !dbg !333
  call void @llvm.dbg.declare(metadata [21 x i8]* %3, metadata !182, metadata !DIExpression()), !dbg !333
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(21) %81, i8* nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.xdp_sock_prog.____fmt, i64 0, i64 0), i64 21, i1 false), !dbg !333
  %82 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %81, i32 21) #3, !dbg !333
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %81) #3, !dbg !334
  %83 = load i32, i32* %2, align 4, !dbg !335, !tbaa !200
  call void @llvm.dbg.value(metadata i32 %83, metadata !115, metadata !DIExpression()), !dbg !191
  %84 = call i32 inttoptr (i64 51 to i32 (i8*, i32, i64)*)(i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*), i32 %83, i64 0) #3, !dbg !336
  br label %85, !dbg !337

85:                                               ; preds = %56, %40, %70, %63, %52, %47, %1, %77, %80
  %86 = phi i32 [ %84, %80 ], [ 2, %40 ], [ 1, %77 ], [ 2, %56 ], [ 2, %1 ], [ 2, %47 ], [ 2, %52 ], [ 2, %63 ], [ 2, %70 ], !dbg !191
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #3, !dbg !338
  ret i32 %86, !dbg !338
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
!llvm.module.flags = !{!98, !99, !100}
!llvm.ident = !{!101}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sdsmvtonvm", scope: !2, file: !73, line: 2760, type: !95, isLocal: false, isDefinition: true)
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
!51 = !{!0, !52, !63, !65, !71, !79, !88}
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !54, line: 18, type: !55, isLocal: false, isDefinition: true)
!54 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !56, line: 33, size: 160, elements: !57)
!56 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!57 = !{!58, !59, !60, !61, !62}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !55, file: !56, line: 34, baseType: !7, size: 32)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !55, file: !56, line: 35, baseType: !7, size: 32, offset: 32)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !55, file: !56, line: 36, baseType: !7, size: 32, offset: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !55, file: !56, line: 37, baseType: !7, size: 32, offset: 96)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !55, file: !56, line: 38, baseType: !7, size: 32, offset: 128)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 18, type: !55, isLocal: false, isDefinition: true)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 139, type: !67, isLocal: false, isDefinition: true)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 32, elements: !69)
!68 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!69 = !{!70}
!70 = !DISubrange(count: 4)
!71 = !DIGlobalVariableExpression(var: !72, expr: !DIExpression())
!72 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !73, line: 33, type: !74, isLocal: true, isDefinition: true)
!73 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DISubroutineType(types: !76)
!76 = !{!46, !46, !77}
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!79 = !DIGlobalVariableExpression(var: !80, expr: !DIExpression())
!80 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !73, line: 152, type: !81, isLocal: true, isDefinition: true)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DISubroutineType(types: !83)
!83 = !{!84, !85, !87, null}
!84 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !68)
!87 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !49, line: 27, baseType: !7)
!88 = !DIGlobalVariableExpression(var: !89, expr: !DIExpression())
!89 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !73, line: 1254, type: !90, isLocal: true, isDefinition: true)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DISubroutineType(types: !92)
!92 = !{!84, !46, !87, !93}
!93 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !49, line: 31, baseType: !94)
!94 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DISubroutineType(types: !97)
!97 = !{!68, !85}
!98 = !{i32 7, !"Dwarf Version", i32 4}
!99 = !{i32 2, !"Debug Info Version", i32 3}
!100 = !{i32 1, !"wchar_size", i32 4}
!101 = !{!"clang version 10.0.0-4ubuntu1 "}
!102 = distinct !DISubprogram(name: "xdp_sock_prog", scope: !3, file: !3, line: 26, type: !103, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !113)
!103 = !DISubroutineType(types: !104)
!104 = !{!84, !105}
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !107)
!107 = !{!108, !109, !110, !111, !112}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !106, file: !6, line: 2857, baseType: !87, size: 32)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !106, file: !6, line: 2858, baseType: !87, size: 32, offset: 32)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !106, file: !6, line: 2859, baseType: !87, size: 32, offset: 64)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !106, file: !6, line: 2861, baseType: !87, size: 32, offset: 96)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !106, file: !6, line: 2862, baseType: !87, size: 32, offset: 128)
!113 = !{!114, !115, !116, !118, !119, !120, !134, !153, !175, !176, !177, !182}
!114 = !DILocalVariable(name: "ctx", arg: 1, scope: !102, file: !3, line: 26, type: !105)
!115 = !DILocalVariable(name: "index", scope: !102, file: !3, line: 28, type: !84)
!116 = !DILocalVariable(name: "pkt_count", scope: !102, file: !3, line: 31, type: !117)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!118 = !DILocalVariable(name: "eth_type", scope: !102, file: !3, line: 44, type: !84)
!119 = !DILocalVariable(name: "ip_type", scope: !102, file: !3, line: 44, type: !84)
!120 = !DILocalVariable(name: "eth", scope: !102, file: !3, line: 45, type: !121)
!121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !122, size: 64)
!122 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !123, line: 168, size: 112, elements: !124)
!123 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!124 = !{!125, !130, !131}
!125 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !122, file: !123, line: 169, baseType: !126, size: 48)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !127, size: 48, elements: !128)
!127 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!128 = !{!129}
!129 = !DISubrange(count: 6)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !122, file: !123, line: 170, baseType: !126, size: 48, offset: 48)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !122, file: !123, line: 171, baseType: !132, size: 16, offset: 96)
!132 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !133, line: 25, baseType: !48)
!133 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!134 = !DILocalVariable(name: "iphdr", scope: !102, file: !3, line: 46, type: !135)
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !136, size: 64)
!136 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !137, line: 86, size: 160, elements: !138)
!137 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!138 = !{!139, !141, !142, !143, !144, !145, !146, !147, !148, !150, !152}
!139 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !136, file: !137, line: 88, baseType: !140, size: 4, flags: DIFlagBitField, extraData: i64 0)
!140 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !49, line: 21, baseType: !127)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !136, file: !137, line: 89, baseType: !140, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !136, file: !137, line: 96, baseType: !140, size: 8, offset: 8)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !136, file: !137, line: 97, baseType: !132, size: 16, offset: 16)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !136, file: !137, line: 98, baseType: !132, size: 16, offset: 32)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !136, file: !137, line: 99, baseType: !132, size: 16, offset: 48)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !136, file: !137, line: 100, baseType: !140, size: 8, offset: 64)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !136, file: !137, line: 101, baseType: !140, size: 8, offset: 72)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !136, file: !137, line: 102, baseType: !149, size: 16, offset: 80)
!149 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !133, line: 31, baseType: !48)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !136, file: !137, line: 103, baseType: !151, size: 32, offset: 96)
!151 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !133, line: 27, baseType: !87)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !136, file: !137, line: 104, baseType: !151, size: 32, offset: 128)
!153 = !DILocalVariable(name: "tcphdr", scope: !102, file: !3, line: 47, type: !154)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !156, line: 25, size: 160, elements: !157)
!156 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!157 = !{!158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !171, !172, !173, !174}
!158 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !155, file: !156, line: 26, baseType: !132, size: 16)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !155, file: !156, line: 27, baseType: !132, size: 16, offset: 16)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !155, file: !156, line: 28, baseType: !151, size: 32, offset: 32)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !155, file: !156, line: 29, baseType: !151, size: 32, offset: 64)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !155, file: !156, line: 31, baseType: !48, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !155, file: !156, line: 32, baseType: !48, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !155, file: !156, line: 33, baseType: !48, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !155, file: !156, line: 34, baseType: !48, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !155, file: !156, line: 35, baseType: !48, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !155, file: !156, line: 36, baseType: !48, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !155, file: !156, line: 37, baseType: !48, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !155, file: !156, line: 38, baseType: !48, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !155, file: !156, line: 39, baseType: !48, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !155, file: !156, line: 40, baseType: !48, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !155, file: !156, line: 55, baseType: !132, size: 16, offset: 112)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !155, file: !156, line: 56, baseType: !149, size: 16, offset: 128)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !155, file: !156, line: 57, baseType: !132, size: 16, offset: 144)
!175 = !DILocalVariable(name: "data_end", scope: !102, file: !3, line: 48, type: !46)
!176 = !DILocalVariable(name: "data", scope: !102, file: !3, line: 49, type: !46)
!177 = !DILocalVariable(name: "nh", scope: !102, file: !3, line: 50, type: !178)
!178 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !179, line: 33, size: 64, elements: !180)
!179 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/ljkim/xdp/xdp_redis/src")
!180 = !{!181}
!181 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !178, file: !179, line: 34, baseType: !46, size: 64)
!182 = !DILocalVariable(name: "____fmt", scope: !183, file: !3, line: 104, type: !188)
!183 = distinct !DILexicalBlock(scope: !184, file: !3, line: 104, column: 13)
!184 = distinct !DILexicalBlock(scope: !185, file: !3, line: 70, column: 24)
!185 = distinct !DILexicalBlock(scope: !186, file: !3, line: 70, column: 12)
!186 = distinct !DILexicalBlock(scope: !187, file: !3, line: 64, column: 33)
!187 = distinct !DILexicalBlock(scope: !102, file: !3, line: 64, column: 9)
!188 = !DICompositeType(tag: DW_TAG_array_type, baseType: !68, size: 168, elements: !189)
!189 = !{!190}
!190 = !DISubrange(count: 21)
!191 = !DILocation(line: 0, scope: !102)
!192 = !DILocation(line: 28, column: 5, scope: !102)
!193 = !DILocation(line: 28, column: 22, scope: !102)
!194 = !{!195, !196, i64 16}
!195 = !{!"xdp_md", !196, i64 0, !196, i64 4, !196, i64 8, !196, i64 12, !196, i64 16}
!196 = !{!"int", !197, i64 0}
!197 = !{!"omnipotent char", !198, i64 0}
!198 = !{!"Simple C/C++ TBAA"}
!199 = !DILocation(line: 28, column: 9, scope: !102)
!200 = !{!196, !196, i64 0}
!201 = !DILocation(line: 33, column: 17, scope: !102)
!202 = !DILocation(line: 48, column: 41, scope: !102)
!203 = !{!195, !196, i64 4}
!204 = !DILocation(line: 48, column: 30, scope: !102)
!205 = !DILocation(line: 48, column: 22, scope: !102)
!206 = !DILocation(line: 49, column: 37, scope: !102)
!207 = !{!195, !196, i64 0}
!208 = !DILocation(line: 49, column: 26, scope: !102)
!209 = !DILocation(line: 49, column: 18, scope: !102)
!210 = !DILocalVariable(name: "nh", arg: 1, scope: !211, file: !179, line: 124, type: !214)
!211 = distinct !DISubprogram(name: "parse_ethhdr", scope: !179, file: !179, line: 124, type: !212, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !216)
!212 = !DISubroutineType(types: !213)
!213 = !{!84, !214, !46, !215}
!214 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !178, size: 64)
!215 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!216 = !{!210, !217, !218}
!217 = !DILocalVariable(name: "data_end", arg: 2, scope: !211, file: !179, line: 125, type: !46)
!218 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !211, file: !179, line: 126, type: !215)
!219 = !DILocation(line: 0, scope: !211, inlinedAt: !220)
!220 = distinct !DILocation(line: 51, column: 16, scope: !102)
!221 = !DILocalVariable(name: "nh", arg: 1, scope: !222, file: !179, line: 79, type: !214)
!222 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !179, file: !179, line: 79, type: !223, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !232)
!223 = !DISubroutineType(types: !224)
!224 = !{!84, !214, !46, !215, !225}
!225 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !226, size: 64)
!226 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !179, line: 64, size: 32, elements: !227)
!227 = !{!228}
!228 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !226, file: !179, line: 65, baseType: !229, size: 32)
!229 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 32, elements: !230)
!230 = !{!231}
!231 = !DISubrange(count: 2)
!232 = !{!221, !233, !234, !235, !236, !237, !238, !244, !245}
!233 = !DILocalVariable(name: "data_end", arg: 2, scope: !222, file: !179, line: 80, type: !46)
!234 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !222, file: !179, line: 81, type: !215)
!235 = !DILocalVariable(name: "vlans", arg: 4, scope: !222, file: !179, line: 82, type: !225)
!236 = !DILocalVariable(name: "eth", scope: !222, file: !179, line: 84, type: !121)
!237 = !DILocalVariable(name: "hdrsize", scope: !222, file: !179, line: 85, type: !84)
!238 = !DILocalVariable(name: "vlh", scope: !222, file: !179, line: 86, type: !239)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!240 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !179, line: 42, size: 32, elements: !241)
!241 = !{!242, !243}
!242 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !240, file: !179, line: 43, baseType: !132, size: 16)
!243 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !240, file: !179, line: 44, baseType: !132, size: 16, offset: 16)
!244 = !DILocalVariable(name: "h_proto", scope: !222, file: !179, line: 87, type: !48)
!245 = !DILocalVariable(name: "i", scope: !222, file: !179, line: 88, type: !84)
!246 = !DILocation(line: 0, scope: !222, inlinedAt: !247)
!247 = distinct !DILocation(line: 129, column: 9, scope: !211, inlinedAt: !220)
!248 = !DILocation(line: 93, column: 14, scope: !249, inlinedAt: !247)
!249 = distinct !DILexicalBlock(scope: !222, file: !179, line: 93, column: 6)
!250 = !DILocation(line: 93, column: 24, scope: !249, inlinedAt: !247)
!251 = !DILocation(line: 93, column: 6, scope: !222, inlinedAt: !247)
!252 = !DILocation(line: 97, column: 10, scope: !222, inlinedAt: !247)
!253 = !DILocation(line: 99, column: 17, scope: !222, inlinedAt: !247)
!254 = !{!255, !255, i64 0}
!255 = !{!"short", !197, i64 0}
!256 = !DILocation(line: 0, scope: !257, inlinedAt: !247)
!257 = distinct !DILexicalBlock(scope: !258, file: !179, line: 109, column: 7)
!258 = distinct !DILexicalBlock(scope: !259, file: !179, line: 105, column: 39)
!259 = distinct !DILexicalBlock(scope: !260, file: !179, line: 105, column: 2)
!260 = distinct !DILexicalBlock(scope: !222, file: !179, line: 105, column: 2)
!261 = !DILocation(line: 105, column: 2, scope: !260, inlinedAt: !247)
!262 = !DILocation(line: 106, column: 7, scope: !258, inlinedAt: !247)
!263 = !DILocation(line: 109, column: 11, scope: !257, inlinedAt: !247)
!264 = !DILocation(line: 109, column: 15, scope: !257, inlinedAt: !247)
!265 = !DILocation(line: 109, column: 7, scope: !258, inlinedAt: !247)
!266 = !DILocation(line: 112, column: 18, scope: !258, inlinedAt: !247)
!267 = !DILocation(line: 57, column: 18, scope: !268)
!268 = distinct !DILexicalBlock(scope: !102, file: !3, line: 57, column: 9)
!269 = !DILocation(line: 158, column: 10, scope: !270, inlinedAt: !281)
!270 = distinct !DILexicalBlock(scope: !271, file: !179, line: 158, column: 6)
!271 = distinct !DISubprogram(name: "parse_iphdr", scope: !179, file: !179, line: 151, type: !272, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !275)
!272 = !DISubroutineType(types: !273)
!273 = !{!84, !214, !46, !274}
!274 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !135, size: 64)
!275 = !{!276, !277, !278, !279, !280}
!276 = !DILocalVariable(name: "nh", arg: 1, scope: !271, file: !179, line: 151, type: !214)
!277 = !DILocalVariable(name: "data_end", arg: 2, scope: !271, file: !179, line: 152, type: !46)
!278 = !DILocalVariable(name: "iphdr", arg: 3, scope: !271, file: !179, line: 153, type: !274)
!279 = !DILocalVariable(name: "iph", scope: !271, file: !179, line: 155, type: !135)
!280 = !DILocalVariable(name: "hdrsize", scope: !271, file: !179, line: 156, type: !84)
!281 = distinct !DILocation(line: 58, column: 19, scope: !282)
!282 = distinct !DILexicalBlock(scope: !268, file: !3, line: 57, column: 42)
!283 = !DILocation(line: 158, column: 14, scope: !270, inlinedAt: !281)
!284 = !DILocation(line: 53, column: 9, scope: !102)
!285 = !DILocation(line: 0, scope: !271, inlinedAt: !281)
!286 = !DILocation(line: 161, column: 17, scope: !271, inlinedAt: !281)
!287 = !DILocation(line: 161, column: 21, scope: !271, inlinedAt: !281)
!288 = !DILocation(line: 163, column: 13, scope: !289, inlinedAt: !281)
!289 = distinct !DILexicalBlock(scope: !271, file: !179, line: 163, column: 5)
!290 = !DILocation(line: 163, column: 5, scope: !271, inlinedAt: !281)
!291 = !DILocation(line: 163, column: 5, scope: !289, inlinedAt: !281)
!292 = !DILocation(line: 167, column: 14, scope: !293, inlinedAt: !281)
!293 = distinct !DILexicalBlock(scope: !271, file: !179, line: 167, column: 6)
!294 = !DILocation(line: 167, column: 24, scope: !293, inlinedAt: !281)
!295 = !DILocation(line: 167, column: 6, scope: !271, inlinedAt: !281)
!296 = !DILocation(line: 173, column: 14, scope: !271, inlinedAt: !281)
!297 = !{!298, !197, i64 9}
!298 = !{!"iphdr", !197, i64 0, !197, i64 0, !197, i64 1, !255, i64 2, !255, i64 4, !255, i64 6, !197, i64 8, !197, i64 9, !255, i64 10, !196, i64 12, !196, i64 16}
!299 = !DILocation(line: 64, column: 17, scope: !187)
!300 = !DILocation(line: 254, column: 8, scope: !301, inlinedAt: !312)
!301 = distinct !DILexicalBlock(scope: !302, file: !179, line: 254, column: 6)
!302 = distinct !DISubprogram(name: "parse_tcphdr", scope: !179, file: !179, line: 247, type: !303, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !306)
!303 = !DISubroutineType(types: !304)
!304 = !{!84, !214, !46, !305}
!305 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !154, size: 64)
!306 = !{!307, !308, !309, !310, !311}
!307 = !DILocalVariable(name: "nh", arg: 1, scope: !302, file: !179, line: 247, type: !214)
!308 = !DILocalVariable(name: "data_end", arg: 2, scope: !302, file: !179, line: 248, type: !46)
!309 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !302, file: !179, line: 249, type: !305)
!310 = !DILocalVariable(name: "len", scope: !302, file: !179, line: 251, type: !84)
!311 = !DILocalVariable(name: "h", scope: !302, file: !179, line: 252, type: !154)
!312 = distinct !DILocation(line: 66, column: 13, scope: !313)
!313 = distinct !DILexicalBlock(scope: !186, file: !3, line: 66, column: 13)
!314 = !DILocation(line: 254, column: 12, scope: !301, inlinedAt: !312)
!315 = !DILocation(line: 64, column: 9, scope: !102)
!316 = !DILocation(line: 0, scope: !302, inlinedAt: !312)
!317 = !DILocation(line: 257, column: 11, scope: !302, inlinedAt: !312)
!318 = !DILocation(line: 257, column: 16, scope: !302, inlinedAt: !312)
!319 = !DILocation(line: 259, column: 9, scope: !320, inlinedAt: !312)
!320 = distinct !DILexicalBlock(scope: !302, file: !179, line: 259, column: 5)
!321 = !DILocation(line: 259, column: 5, scope: !302, inlinedAt: !312)
!322 = !DILocation(line: 259, column: 5, scope: !320, inlinedAt: !312)
!323 = !DILocation(line: 263, column: 14, scope: !324, inlinedAt: !312)
!324 = distinct !DILexicalBlock(scope: !302, file: !179, line: 263, column: 6)
!325 = !DILocation(line: 263, column: 20, scope: !324, inlinedAt: !312)
!326 = !DILocation(line: 70, column: 20, scope: !185)
!327 = !DILocation(line: 70, column: 12, scope: !185)
!328 = !DILocation(line: 263, column: 6, scope: !302, inlinedAt: !312)
!329 = !DILocation(line: 72, column: 27, scope: !330)
!330 = distinct !DILexicalBlock(scope: !184, file: !3, line: 72, column: 16)
!331 = !DILocation(line: 72, column: 25, scope: !330)
!332 = !DILocation(line: 72, column: 16, scope: !184)
!333 = !DILocation(line: 104, column: 13, scope: !183)
!334 = !DILocation(line: 104, column: 13, scope: !184)
!335 = !DILocation(line: 108, column: 48, scope: !184)
!336 = !DILocation(line: 108, column: 20, scope: !184)
!337 = !DILocation(line: 108, column: 13, scope: !184)
!338 = !DILocation(line: 122, column: 1, scope: !102)
