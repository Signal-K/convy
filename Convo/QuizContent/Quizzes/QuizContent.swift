//
//  QuizContent.swift
//  Convo
//
//  Created by Liam Arbuckle on 4/7/2025.
//

import Foundation

struct QuizContent {
    static let all: [String: [QuizQuestion]] = [
        "Start a Conversation": [
            QuizQuestion(
                question: "You see a broken vase and Liam looking uneasy. How should you begin the conversation?",
                answers: [
                    "A. \"Liam, why did you break this vase?\"",
                    "B. \"I see the vase is broken. Can you tell me what happened when you're ready?\"",
                    "C. \"You need to clean this up right now!\"",
                    "D. \"That was very careless of you.\""
                ],
                correctAnswer: "B. \"I see the vase is broken. Can you tell me what happened when you're ready?\""
            ),
            QuizQuestion(
                question: "Liam looks at you but doesn't speak yet. How can you open the conversation gently?",
                answers: [
                    "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\"",
                    "B. \"Why won't you just tell me what you did? You can't hide from me.\"",
                    "C. \"I'm really upset that you didn't tell me right away; you need to be honest.\"",
                    "D. \"If you don't explain now, you'll be in trouble later.\""
                ],
                correctAnswer: "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\""
            ),
            QuizQuestion(
                question: "Liam is still quiet but seems less tense. What's the best way to ask him to talk?",
                answers: [
                    "A. \"Can you tell me in your own words what happened? I'm here to listen.\"",
                    "B. \"You need to explain everything now, or there will be consequences.\"",
                    "C. \"Stop hiding it and tell me right away, or I'll be really angry.\"",
                    "D. \"I don't want excuses, just the truth so we can fix this.\""
                ],
                correctAnswer: "A. \"Can you tell me in your own words what happened? I'm here to listen.\""
            ),
            QuizQuestion(
                question: "Liam says, \"I accidentally knocked the vase off the table while reaching for my toy.\" How should you respond?",
                answers: [
                    "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\"",
                    "B. \"That's careless! You should be more careful next time or you'll be in trouble.\"",
                    "C. \"I don't believe you; you must be lying to avoid getting punished.\"",
                    "D. \"Well, now we have to be extra careful because of your mistake.\""
                ],
                correctAnswer: "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\""
            ),
            QuizQuestion(
                question: "Liam looks scared and says, \"I didn't mean to break it.\" What's the best way to respond?",
                answers: [
                    "A. \"It's okay to feel scared, accidents happen.\"",
                    "B. \"Stop crying; it's just a vase, nothing to get upset about.\"",
                    "C. \"You should be ashamed of yourself for being so careless.\"",
                    "D. \"I'm really disappointed in you for breaking something valuable.\""
                ],
                correctAnswer: "A. \"It's okay to feel scared, accidents happen.\""
            ),
            QuizQuestion(
                question: "Liam looks worried after breaking the vase. What is the best way to guide him in problem solving?",
                answers: [
                    "A. \"Let's think of how we can clean this up and maybe fix it.\"",
                    "B. \"You need to clean this mess up yourself or you'll get in trouble.\"",
                    "C. \"You should have been more careful; this is all your fault.\"",
                    "D. \"I'll take care of it since you can't seem to handle anything properly.\""
                ],
                correctAnswer: "A. \"Let's think of how we can clean this up and maybe fix it.\""
            ),
            QuizQuestion(
                question: "After helping Liam clean up, you want to explain why it's important to be careful around breakable things. What is the best way to explain this principle?",
                answers: [
                    "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\"",
                    "B. \"If you break something again, there will be serious consequences, so watch yourself.\"",
                    "C. \"You should always be perfect and never make mistakes with important things.\"",
                    "D. \"I don't want to see you near anything fragile again because you're careless.\""
                ],
                correctAnswer: "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\""
            ),
            QuizQuestion(
                question: "Liam looks worried after your explanation and asks if you're angry with him. How should you respond to reassure him best?",
                answers: [
                    "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\"",
                    "B. \"Of course I'm angry! You broke something important, and that's frustrating.\"",
                    "C. \"Well, you should be more careful, so I'm a little upset.\"",
                    "D. \"I don't have time to be angry with you right now. Just be careful.\""
                ],
                correctAnswer: "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\""
            ),
            QuizQuestion(
                question: "After the conversation, Liam seems calmer but unsure what to do next. How can you help him get back to his usual activities smoothly?",
                answers: [
                    "A. \"Let's tidy up together, then you can go play outside like normal.\"",
                    "B. \"You need to sit quietly for a while and think about what happened.\"",
                    "C. \"Just go to your room and don't come out until you've calmed down.\"",
                    "D. \"Stop worrying about it and get back to what you were doing immediately.\""
                ],
                correctAnswer: "A. \"Let's tidy up together, then you can go play outside like normal.\""
            ),
            QuizQuestion(
                question: "You want Liam to feel safe coming to you next time he's upset or makes a mistake. What's the best way to encourage future communication?",
                answers: [
                    "A. \"Remember, you can always come to me if something's wrong — no matter what.\"",
                    "B. \"Don't ever keep secrets from me again or there will be consequences.\"",
                    "C. \"Try not to mess up next time; I won't be so patient.\"",
                    "D. \"If you cause trouble again, you'll be in big trouble.\""
                ],
                correctAnswer: "A. \"Remember, you can always come to me if something's wrong — no matter what.\""
            )
        ],
        
        "Turning an acquaintance to a friend": [
            QuizQuestion(
                question: "What’s the best way to open the conversation?",
                answers: [
                    "“Hey, I’ve been meaning to say hi, how’s your day?”",
                    "“Why don’t you ever talk to anyone around here?”",
                    "“Your plants look alright, I guess.”",
                    "“You’re always so quiet; don’t you have friends?”"
                ],
                correctAnswer: "“Hey, I’ve been meaning to say hi, how’s your day?”"
            ),
            QuizQuestion(
                question: "What’s a good topic to keep the conversation going?",
                answers: [
                    "“Nice weather today, isn’t it? Perfect for gardening.”",
                    "“Why do you always stay inside on weekends?”",
                    "“Have you read anything interesting lately, or is it just boring stuff?”",
                    "“I don’t really care what you do, but we should talk more.”"
                ],
                correctAnswer: "“Nice weather today, isn’t it? Perfect for gardening.”"
            ),
            QuizQuestion(
                question: "What’s a good way to respond to Alex saying they like hiking?",
                answers: [
                    "“Oh, I love hiking too! Have you explored any nearby trails recently?”",
                    "“Hiking sounds boring; I prefer watching TV all day.”",
                    "“That’s nice, but I don’t really care about outdoor stuff.”",
                    "“Why would anyone want to walk around in the dirt for fun?”"
                ],
                correctAnswer: "“Oh, I love hiking too! Have you explored any nearby trails recently?”"
            ),
            QuizQuestion(
                question: "What’s a good way to talk about your interest in cooking?",
                answers: [
                    "“I’m trying to get better at cooking—any favorite recipes you recommend?”",
                    "“I’m so much better at cooking than most people.”",
                    "“I don’t cook much, and I don’t want to talk about it.”",
                    "“Cooking is useless; takeout is way easier.”"
                ],
                correctAnswer: "“I’m trying to get better at cooking—any favorite recipes you recommend?”"
            ),
            QuizQuestion(
                question: "How do you best show you’re actively listening?",
                answers: [
                    "“That sounds amazing! What was your favorite part of the hike?”",
                    "“Yeah, whatever. I’m not really interested.”",
                    "“I’m bored, can we change the subject?”",
                    "“I don’t see why people get so excited about hiking.”"
                ],
                correctAnswer: "“That sounds amazing! What was your favorite part of the hike?”"
            ),
            QuizQuestion(
                question: "What’s a good way to deepen the connection after laughing together?",
                answers: [
                    "“That was hilarious! We should swap more stories sometime.”",
                    "“I’m glad you messed up, that makes you less annoying.”",
                    "“I don’t have time to listen to silly stories.”",
                    "“You’re always so clumsy, aren’t you?”"
                ],
                correctAnswer: "“That was hilarious! We should swap more stories sometime.”"
            ),
            QuizQuestion(
                question: "How do you casually suggest a get-together?",
                answers: [
                    "“If you’re interested, maybe we could grab coffee sometime?”",
                    "“You have to hang out with me this weekend, no excuses.”",
                    "“I guess you probably don’t want to spend time with me.”",
                    "“You better come to my place or I won’t talk to you again.”"
                ],
                correctAnswer: "“If you’re interested, maybe we could grab coffee sometime?”"
            ),
            QuizQuestion(
                question: "What’s the best response when Alex seems unsure?",
                answers: [
                    "“No worries, maybe another time when it’s better for you.”",
                    "“You’re just making excuses to avoid me.”",
                    "“If you don’t want to hang out, just say so.”",
                    "“Fine, I guess you don’t care about this friendship.”"
                ],
                correctAnswer: "“No worries, maybe another time when it’s better for you.”"
            ),
            QuizQuestion(
                question: "What’s a good way to wrap up the chat?",
                answers: [
                    "“It was really nice talking to you, have a great day!”",
                    "“I’m glad this is over; see you around.”",
                    "“Well, don’t forget to call me next time you want to hang out.”",
                    "“I’m bored, I’m leaving now.”"
                ],
                correctAnswer: "“It was really nice talking to you, have a great day!”"
            ),
            QuizQuestion(
                question: "What’s a casual way to ask to stay in touch?",
                answers: [
                    "“Would you like to exchange numbers or maybe chat online sometime?”",
                    "“Give me your number or I won’t talk to you again.”",
                    "“I’m too busy to keep this up, but you can try reaching me.”",
                    "“Don’t bother contacting me if you’re not serious.”"
                ],
                correctAnswer: "“Would you like to exchange numbers or maybe chat online sometime?”"
            )
        ],
        
        "Deepening Intimacy": [
            QuizQuestion(
                question: "Alex just walked through the front door, looking drained. You're sitting on the couch and want to gently acknowledge their presence. What's the best way to greet Alex?",
                answers: [
                    "A. \"Hey love, you look wiped out. Want a few minutes to decompress?\"",
                    "B. \"You look terrible. What happened today?\"",
                    "C. \"Finally, you're home. I've been waiting for hours.\"",
                    "D. \"Busy day? We need to talk about dinner and the sink.\""
                ],
                correctAnswer: "A. \"Hey love, you look wiped out. Want a few minutes to decompress?\""
            ),
            QuizQuestion(
                question: "A few minutes later, Alex has changed into more comfortable clothes and sits beside you. You want to start a light, friendly conversation without overwhelming them. What's the best approach?",
                answers: [
                    "A. \"So, what kind of chaos did you survive at work today?\"",
                    "B. \"Hey, how was the commute?\"",
                    "C. \"Did you remember to email back that client you mentioned this morning?\"",
                    "D. \"Let's talk about something positive — what's for dinner?\""
                ],
                correctAnswer: "B. \"Hey, how was the commute?\""
            ),
            QuizQuestion(
                question: "Alex gives a small smile and says, \"Commute was okay. Long day though.\" Their voice is a bit tired. You want to respond in a way that matches their mood. What's the best response?",
                answers: [
                    "A. \"I totally get that. Want to decompress for a bit first?\"",
                    "B. \"Tell me everything that happened today, I'm all ears!\"",
                    "C. \"Ugh, my day was worse. I'll trade you stress for stress.\"",
                    "D. \"Well, I have lots to talk about too, but you go first.\""
                ],
                correctAnswer: "A. \"I totally get that. Want to decompress for a bit first?\""
            ),
            QuizQuestion(
                question: "After a short pause, Alex sits down and starts scrolling on their phone. You want to gently check in on how they've been feeling lately. What's the best way to begin?",
                answers: [
                    "A. \"How have you been feeling overall lately? You've seemed kind of quiet.\"",
                    "B. \"You okay? You've been moody a lot.\"",
                    "C. \"I've noticed you on your phone more — is everything alright with us?\"",
                    "D. \"Is there something wrong or are you just tired all the time now?\""
                ],
                correctAnswer: "A. \"How have you been feeling overall lately? You've seemed kind of quiet.\""
            ),
            QuizQuestion(
                question: "Alex replies, \"I've just been tired, I guess.\" Their tone is flat but not closed off. You want to offer a little vulnerability of your own. What's a good way to respond?",
                answers: [
                    "A. \"Yeah, I know how that feels. I've been feeling a bit disconnected from everything lately, including us.\"",
                    "B. \"You always say you're just tired. I don't think that's really it.\"",
                    "C. \"Well, at least you don't have to deal with my job lately — it's been horrible.\"",
                    "D. \"That's okay. I guess it's just one of those weeks. Want to order food?\""
                ],
                correctAnswer: "A. \"Yeah, I know how that feels. I've been feeling a bit disconnected from everything lately, including us.\""
            ),
            QuizQuestion(
                question: "After your gentle self-disclosure, Alex looks up and says, \"Yeah... I've been feeling kind of disconnected too. I don't even know why, really.\" How should you respond to encourage them to keep sharing?",
                answers: [
                    "A. \"That makes sense. Do you want to talk about what's been on your mind lately?\"",
                    "B. \"We're probably just bored or stuck in a rut.\"",
                    "C. \"See, I knew something was going on. You've been acting distant all week.\"",
                    "D. \"Disconnection's a weird feeling. I've been trying to just ignore it.\""
                ],
                correctAnswer: "A. \"That makes sense. Do you want to talk about what's been on your mind lately?\""
            ),
            QuizQuestion(
                question: "Alex opens up more and says, \"I don't want you to think I'm pulling away or anything. I've just been overwhelmed and tired lately.\" What's the best way to reassure your partner?",
                answers: [
                    "A. \"I get it. Thank you for telling me — it means a lot.\"",
                    "B. \"Well, maybe try not to shut me out next time.\"",
                    "C. \"I guess we've both been pretty off lately.\"",
                    "D. \"It's okay, but that kind of tiredness can be dangerous for relationships.\""
                ],
                correctAnswer: "A. \"I get it. Thank you for telling me — it means a lot.\""
            ),
            QuizQuestion(
                question: "The conversation has taken a warm turn. You both feel closer after sharing. You want to suggest a small, bonding activity to continue building connection. What's the best approach?",
                answers: [
                    "A. \"Want to go for a walk together after dinner? Just the two of us.\"",
                    "B. \"Cool. Let's just chill separately for a bit, I think we're good.\"",
                    "C. \"Maybe we should sit down and plan our finances — we've been putting that off.\"",
                    "D. \"You could use some alone time, I won't bother you anymore tonight.\""
                ],
                correctAnswer: "A. \"Want to go for a walk together after dinner? Just the two of us.\""
            ),
            QuizQuestion(
                question: "After a meaningful talk, the mood feels tender but a little heavy. You want to lighten the atmosphere and show affection without dismissing feelings. How do you best introduce lightness?",
                answers: [
                    "A. \"Remember that silly dance you did last time? Let's see if you still got it!\"",
                    "B. \"Well, I guess we can just be serious all night, no fun allowed.\"",
                    "C. \"I'm really tired, so I'm going to bed now.\"",
                    "D. \"I don't think joking about this stuff helps at all.\""
                ],
                correctAnswer: "A. \"Remember that silly dance you did last time? Let's see if you still got it!\""
            ),
            QuizQuestion(
                question: "The evening is winding down. You want to leave a warm, lasting impression that strengthens your connection. What's the best way to say goodnight?",
                answers: [
                    "A. \"I really enjoyed this time with you. Sleep well, and let's catch up again soon.\"",
                    "B. \"Alright, I'm off. Don't bother texting me tonight.\"",
                    "C. \"Goodnight. Hope you don't keep me up with your problems.\"",
                    "D. \"Bye. Talk later, maybe.\""
                ],
                correctAnswer: "A. \"I really enjoyed this time with you. Sleep well, and let's catch up again soon.\""
            )
        ]
    ]
}
