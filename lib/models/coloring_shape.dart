class ColoringShape {
  final String id;
  final String nameKey;
  final String imageUrl;
  final String category;

  ColoringShape({
    required this.id,
    required this.nameKey,
    required this.imageUrl,
    required this.category,
  });
}

final List<ColoringShape> sampleShapes = [
  ColoringShape(
    id: 'dog',
    nameKey: 'dog',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDygEOhhaMm3zYX576PL0hO694T5ZCYsmFSvCwllKNhlQlsLSpG_bhpSR9qgDjd-WjyLFTBK28KoUVQysin62R8TwjCSm_7-8KNHIhoMwtzn03Xc6S7TzsVOPlNXmt4o0myPjed7Q7gZjYVNFa67ksDkszD4tjZyxZ30VxX6bklMOOK4WThre3On8OOWqrcEQDLNgB7QfJ9Q8u7jzJEg50bhC7aOm3XO7UJv7tDqbQFSRjRdRMcYN350dJV6IihFpI_ldV0_YwwenRm',
    category: 'animals',
  ),
  ColoringShape(
    id: 'cat',
    nameKey: 'cat',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA3Ech_1UDLSLl6w2Dj6XLOhpeAO7--FrU3KwH9Oaa5Odrz7G1iQ-le4sM3p1e5Kdrd0HfT8h4SoraACb-JeFx9iw3uuML-JAnuPXavp4_8sqq1F7qGP-75TLpHC6z_bRSUGzEKg5dxhAcuE7-SYNNfAEE_u0C5oaUI4yzpnxELgRBSN6J0tTsG2L20Vy9vX7kSrIHT58VRgcmXYYPYjzi3gijE6MFtDLZREkLlzcCyeNe9qWa086k_89PselP_p0FJKplOMBfabWX9',
    category: 'animals',
  ),
  ColoringShape(
    id: 'bird',
    nameKey: 'bird',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCypvAQezdV3LAV6itaMm_ANN4rqSs0lD3spBepyIZh3trLftUN2aztQlzhN-0z8oUnSt4hda1X7Un7z2_zjjz8UE44QLv8F6ogH0C0GpaIIxhXdlxBRMvu9a6lxP6SjGfuWF_YEpj0EJraN4iQ5v3KtcK9fDmgqxpPgIHglu11g6Z-PZ2FJiKptXB7CuLhbqxI4Ipq1CTBONqeG4_tsJBbC82aQiVSdtomCrVF9Vv5Tl9tUnTOMcBRxb7AKhe1Jwwwgj8yv87VnGa6',
    category: 'animals',
  ),
  ColoringShape(
    id: 'rabbit',
    nameKey: 'rabbit',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC-yAQcQExCfleLsB9d1lJ68O9bBZcfwJzwWoXNnueVQPM7W6IyNeWfbcct20lOAEsMwG8nSuzIV5aZXetRNT0ElGptTmyiZjupL1xIOeITnaZud3RmASa2kH5WRkfD6YLEo8SAop4tcq4JDvk_dATUJAdejF3nVr_MlMqde72RxyfDwVo4nbQQUCky3xBL8homh2dG4u0L0JiVmxpfqxV9cmqD4Tq_dCDuTevWtafaXNGjCqFLYNhQVQoYfYXWf5YYvBFOxNB67hCB',
    category: 'animals',
  ),
  ColoringShape(
    id: 'elephant',
    nameKey: 'elephant',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBFNMJzN5lf7N-HorqfEKzndj460lUaYGDklfmYDDDBOZUfdJI_-7pRgWg_JBHswwC3xVET-UNkMTaUz1EtohEbwgcXgRd59VbnRxrGC-OxK43OagRfdVZyawPHYhvmFNoegD48XZeluctvThXifXZWOZwVjzVcpzAnrzvSOn-7vx9cj13hUDWbq7r1is0lx__qkRnUtLnHHzhghlzEeSIou5KH6vqLKSjg2QC9rUne98eRmfqIx4bSSGBGfVIpfOp2G_cuujQHrPhi',
    category: 'animals',
  ),
  ColoringShape(
    id: 'lion',
    nameKey: 'lion',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCFXKC15hqCqVrTCsJXBFqArp5kBgaBl1rKC8R3RlPAEmTSGrRwhjZH7R8wSAsD4nPBHSCL6UvulIFLZgvy2ZRovxvvzfz_e9hcyjtg_rKNewmxcyvzqVlxEPDUZbqT6YA_vsaPthbtkeRPOugYMWubvLn_fymdYKge8YkUktcd6Wi2ByNPrKF_IYSEzr3KcMUh5UBahH9F2EAm921ycHMo8kDq_90ECVUWbcmxzFYSL8U3iGLl7HVN62o1OAuUAZ-l-Iz6Z3hwjcF-',
    category: 'animals',
  ),
];
