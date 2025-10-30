//
//  MaskList.swift
//  HairScan
//
//  Created by Pasquale Pagano on 30/10/25.
//

struct MaskList{
    let hairCondition: String
    let maskName: String
    let ingredients: String
    let benefit: String
    let applicationTime: String
    let frequency: String
    let usageNote: String
}

let healthyHairMasks: [MaskList] = [
    MaskList(
        hairCondition: "Healthy hair",
        maskName: "Yogurt & Flaxseed Shine Mask",
        ingredients: "1 tbsp plain yogurt, 1 tsp flaxseed oil, 1 tsp honey",
        benefit: "Adds shine, hydration, and smooth texture; maintains healthy scalp",
        applicationTime: "15–20 min",
        frequency: "Every 2 weeks",
        usageNote: "Apply to wet hair; rinse well to avoid residue"
    ),
    MaskList(
        hairCondition: "Healthy hair",
        maskName: "Green Tea & Honey Balance Mask",
        ingredients: "2 tbsp brewed green tea (cooled), 1 tbsp honey, 1 tsp jojoba oil",
        benefit: "Rich in antioxidants that protect hair from environmental damage; keeps scalp balanced and adds shine",
        applicationTime: "15–20 min",
        frequency: "Every 2–3 weeks",
        usageNote: "Apply to clean; massage gently into scalp and lengths, rinse thoroughly with lukewarm water"
    )
]

let damagedHairMask: [MaskList] = [
    MaskList(
        hairCondition: "Damaged hair",
        maskName: "Banana & Honey Moisture Mask",
        ingredients: "1 banana, 1 tbsp honey, 1 tsp coconut oil",
        benefit: "Restores moisture balance, reduces frizz, and improves elasticity",
        applicationTime: "25–30 min",
        frequency: "1× per week",
        usageNote: "Blend until smooth to avoid banana chunks; apply evenly to lengths"
    ),
    MaskList(
        hairCondition: "Damaged hair",
        maskName: "Amla & Castor Oil Growth Mask",
        ingredients: "1 tbsp amla oil, 1 tbsp castor oil, few drops rosemary essential oil (optional)",
        benefit: "Promotes growth, strengthens roots, reduces breakage",
        applicationTime: "30–45 min",
        frequency: "Every 2 weeks",
        usageNote: "Massage into scalp before washing; helps boost circulation"
    )
]

let veryDamagedHairMask: [MaskList] = [
    MaskList(
        hairCondition: "Very damaged hair",
        maskName: "Coconut & Aloe Rescue Mask",
        ingredients: "2 tbsp coconut oil, 1 tbsp aloe vera gel, ½ banana (optional)",
        benefit: "Reconstructs from within; hydrates and strengthens; adds softness and shine",
        applicationTime: "30–40 min",
        frequency: "Every 10–14 days",
        usageNote: "Warm slightly before applying; avoid heat styling for 24h after use"
    ),
    MaskList(
        hairCondition: "Very damaged hair",
        maskName: "Olive & Aloe Deep Repair Mask",
        ingredients: "2 tbsp olive oil, 2 tbsp aloe vera gel, 1 tsp argan oil",
        benefit: "Deep repair for over-processed hair; adds elasticity and protection",
        applicationTime: "45–60 min",
        frequency: "Every 2 weeks",
        usageNote: "Cover with warm towel or cap; rinse thoroughly with mild shampoo"
    )
]
