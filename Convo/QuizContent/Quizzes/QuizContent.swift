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
                correctAnswer: "B. \"I see the vase is broken. Can you tell me what happened when you're ready?\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks at you but doesn't speak yet. How can you open the conversation gently?",
                answers: [
                    "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\"",
                    "B. \"Why won't you just tell me what you did? You can't hide from me.\"",
                    "C. \"I'm really upset that you didn't tell me right away; you need to be honest.\"",
                    "D. \"If you don't explain now, you'll be in trouble later.\""
                ],
                correctAnswer: "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\"",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "Liam is still quiet but seems less tense. What's the best way to ask him to talk?",
                answers: [
                    "A. \"Can you tell me in your own words what happened? I'm here to listen.\"",
                    "B. \"You need to explain everything now, or there will be consequences.\"",
                    "C. \"Stop hiding it and tell me right away, or I'll be really angry.\"",
                    "D. \"I don't want excuses, just the truth so we can fix this.\""
                ],
                correctAnswer: "A. \"Can you tell me in your own words what happened? I'm here to listen.\"",
                mainSkill: "Active Listening"
            ),
            QuizQuestion(
                question: "Liam says, \"I accidentally knocked the vase off the table while reaching for my toy.\" How should you respond?",
                answers: [
                    "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\"",
                    "B. \"That's careless! You should be more careful next time or you'll be in trouble.\"",
                    "C. \"I don't believe you; you must be lying to avoid getting punished.\"",
                    "D. \"Well, now we have to be extra careful because of your mistake.\""
                ],
                correctAnswer: "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks scared and says, \"I didn't mean to break it.\" What's the best way to respond?",
                answers: [
                    "A. \"It's okay to feel scared, accidents happen.\"",
                    "B. \"Stop crying; it's just a vase, nothing to get upset about.\"",
                    "C. \"You should be ashamed of yourself for being so careless.\"",
                    "D. \"I'm really disappointed in you for breaking something valuable.\""
                ],
                correctAnswer: "A. \"It's okay to feel scared, accidents happen.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks worried after breaking the vase. What is the best way to guide him in problem solving?",
                answers: [
                    "A. \"Let's think of how we can clean this up and maybe fix it.\"",
                    "B. \"You need to clean this mess up yourself or you'll get in trouble.\"",
                    "C. \"You should have been more careful; this is all your fault.\"",
                    "D. \"I'll take care of it since you can't seem to handle anything properly.\""
                ],
                correctAnswer: "A. \"Let's think of how we can clean this up and maybe fix it.\"",
                mainSkill: "Professional Communication"
            ),
            QuizQuestion(
                question: "After helping Liam clean up, you want to explain why it's important to be careful around breakable things. What is the best way to explain this principle?",
                answers: [
                    "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\"",
                    "B. \"If you break something again, there will be serious consequences, so watch yourself.\"",
                    "C. \"You should always be perfect and never make mistakes with important things.\"",
                    "D. \"I don't want to see you near anything fragile again because you're careless.\""
                ],
                correctAnswer: "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\"",
                mainSkill: "Professional Communication"
            ),
            QuizQuestion(
                question: "Liam looks worried after your explanation and asks if you're angry with him. How should you respond to reassure him best?",
                answers: [
                    "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\"",
                    "B. \"Of course I'm angry! You broke something important, and that's frustrating.\"",
                    "C. \"Well, you should be more careful, so I'm a little upset.\"",
                    "D. \"I don't have time to be angry with you right now. Just be careful.\""
                ],
                correctAnswer: "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "After the conversation, Liam seems calmer but unsure what to do next. How can you help him get back to his usual activities smoothly?",
                answers: [
                    "A. \"Let's tidy up together, then you can go play outside like normal.\"",
                    "B. \"You need to sit quietly for a while and think about what happened.\"",
                    "C. \"Just go to your room and don't come out until you've calmed down.\"",
                    "D. \"Stop worrying about it and get back to what you were doing immediately.\""
                ],
                correctAnswer: "A. \"Let's tidy up together, then you can go play outside like normal.\"",
                mainSkill: "Confidence in Conversation"
            ),
            QuizQuestion(
                question: "You want Liam to feel safe coming to you next time he's upset or makes a mistake. What's the best way to encourage future communication?",
                answers: [
                    "A. \"Remember, you can always come to me if something's wrong — no matter what.\"",
                    "B. \"Don't ever keep secrets from me again or there will be consequences.\"",
                    "C. \"Try not to mess up next time; I won't be so patient.\"",
                    "D. \"If you cause trouble again, you'll be in big trouble.\""
                ],
                correctAnswer: "A. \"Remember, you can always come to me if something's wrong — no matter what.\"",
                mainSkill: "Empathy and Tone"
            )
        ],
        
        "Deepening Intimacy": [
            QuizQuestion(
                question: "You see a broken vase and Liam looking uneasy. How should you begin the conversation?",
                answers: [
                    "A. \"Liam, why did you break this vase?\"",
                    "B. \"I see the vase is broken. Can you tell me what happened when you're ready?\"",
                    "C. \"You need to clean this up right now!\"",
                    "D. \"That was very careless of you.\""
                ],
                correctAnswer: "B. \"I see the vase is broken. Can you tell me what happened when you're ready?\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks at you but doesn't speak yet. How can you open the conversation gently?",
                answers: [
                    "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\"",
                    "B. \"Why won't you just tell me what you did? You can't hide from me.\"",
                    "C. \"I'm really upset that you didn't tell me right away; you need to be honest.\"",
                    "D. \"If you don't explain now, you'll be in trouble later.\""
                ],
                correctAnswer: "A. \"It's okay, Liam. Take your time and tell me what happened when you're ready.\"",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "Liam is still quiet but seems less tense. What's the best way to ask him to talk?",
                answers: [
                    "A. \"Can you tell me in your own words what happened? I'm here to listen.\"",
                    "B. \"You need to explain everything now, or there will be consequences.\"",
                    "C. \"Stop hiding it and tell me right away, or I'll be really angry.\"",
                    "D. \"I don't want excuses, just the truth so we can fix this.\""
                ],
                correctAnswer: "A. \"Can you tell me in your own words what happened? I'm here to listen.\"",
                mainSkill: "Active Listening"
            ),
            QuizQuestion(
                question: "Liam says, \"I accidentally knocked the vase off the table while reaching for my toy.\" How should you respond?",
                answers: [
                    "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\"",
                    "B. \"That's careless! You should be more careful next time or you'll be in trouble.\"",
                    "C. \"I don't believe you; you must be lying to avoid getting punished.\"",
                    "D. \"Well, now we have to be extra careful because of your mistake.\""
                ],
                correctAnswer: "A. \"Thank you for telling me. Accidents happen, and I'm glad you shared it.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks scared and says, \"I didn't mean to break it.\" What's the best way to respond?",
                answers: [
                    "A. \"It's okay to feel scared, accidents happen.\"",
                    "B. \"Stop crying; it's just a vase, nothing to get upset about.\"",
                    "C. \"You should be ashamed of yourself for being so careless.\"",
                    "D. \"I'm really disappointed in you for breaking something valuable.\""
                ],
                correctAnswer: "A. \"It's okay to feel scared, accidents happen.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "Liam looks worried after breaking the vase. What is the best way to guide him in problem solving?",
                answers: [
                    "A. \"Let's think of how we can clean this up and maybe fix it.\"",
                    "B. \"You need to clean this mess up yourself or you'll get in trouble.\"",
                    "C. \"You should have been more careful; this is all your fault.\"",
                    "D. \"I'll take care of it since you can't seem to handle anything properly.\""
                ],
                correctAnswer: "A. \"Let's think of how we can clean this up and maybe fix it.\"",
                mainSkill: "Professional Communication"
            ),
            QuizQuestion(
                question: "After helping Liam clean up, you want to explain why it's important to be careful around breakable things. What is the best way to explain this principle?",
                answers: [
                    "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\"",
                    "B. \"If you break something again, there will be serious consequences, so watch yourself.\"",
                    "C. \"You should always be perfect and never make mistakes with important things.\"",
                    "D. \"I don't want to see you near anything fragile again because you're careless.\""
                ],
                correctAnswer: "A. \"Things can get broken if we're not careful, and it can cost money to replace them.\"",
                mainSkill: "Professional Communication"
            ),
            QuizQuestion(
                question: "Liam looks worried after your explanation and asks if you're angry with him. How should you respond to reassure him best?",
                answers: [
                    "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\"",
                    "B. \"Of course I'm angry! You broke something important, and that's frustrating.\"",
                    "C. \"Well, you should be more careful, so I'm a little upset.\"",
                    "D. \"I don't have time to be angry with you right now. Just be careful.\""
                ],
                correctAnswer: "A. \"No, I'm not angry. I just want to make sure you learn to be careful next time.\"",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "After the conversation, Liam seems calmer but unsure what to do next. How can you help him get back to his usual activities smoothly?",
                answers: [
                    "A. \"Let's tidy up together, then you can go play outside like normal.\"",
                    "B. \"You need to sit quietly for a while and think about what happened.\"",
                    "C. \"Just go to your room and don't come out until you've calmed down.\"",
                    "D. \"Stop worrying about it and get back to what you were doing immediately.\""
                ],
                correctAnswer: "A. \"Let's tidy up together, then you can go play outside like normal.\"",
                mainSkill: "Confidence in Conversation"
            ),
            QuizQuestion(
                question: "You want Liam to feel safe coming to you next time he's upset or makes a mistake. What's the best way to encourage future communication?",
                answers: [
                    "A. \"Remember, you can always come to me if something's wrong — no matter what.\"",
                    "B. \"Don't ever keep secrets from me again or there will be consequences.\"",
                    "C. \"Try not to mess up next time; I won't be so patient.\"",
                    "D. \"If you cause trouble again, you'll be in big trouble.\""
                ],
                correctAnswer: "A. \"Remember, you can always come to me if something's wrong — no matter what.\"",
                mainSkill: "Empathy and Tone"
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
                correctAnswer: "“Hey, I’ve been meaning to say hi, how’s your day?”",
                mainSkill: "Small Talk Mastery"
            ),
            QuizQuestion(
                question: "What’s a good topic to keep the conversation going?",
                answers: [
                    "“Nice weather today, isn’t it? Perfect for gardening.”",
                    "“Why do you always stay inside on weekends?”",
                    "“Have you read anything interesting lately, or is it just boring stuff?”",
                    "“I don’t really care what you do, but we should talk more.”"
                ],
                correctAnswer: "“Nice weather today, isn’t it? Perfect for gardening.”",
                mainSkill: "Small Talk Mastery"
            ),
            QuizQuestion(
                question: "What’s a good way to respond to Alex saying they like hiking?",
                answers: [
                    "“Oh, I love hiking too! Have you explored any nearby trails recently?”",
                    "“Hiking sounds boring; I prefer watching TV all day.”",
                    "“That’s nice, but I don’t really care about outdoor stuff.”",
                    "“Why would anyone want to walk around in the dirt for fun?”"
                ],
                correctAnswer: "“Oh, I love hiking too! Have you explored any nearby trails recently?”",
                mainSkill: "Active Listening"
            ),
            QuizQuestion(
                question: "What’s a good way to talk about your interest in cooking?",
                answers: [
                    "“I’m trying to get better at cooking—any favorite recipes you recommend?”",
                    "“I’m so much better at cooking than most people.”",
                    "“I don’t cook much, and I don’t want to talk about it.”",
                    "“Cooking is useless; takeout is way easier.”"
                ],
                correctAnswer: "“I’m trying to get better at cooking—any favorite recipes you recommend?”",
                mainSkill: "Confidence in Conversation"
            ),
            QuizQuestion(
                question: "How do you best show you’re actively listening?",
                answers: [
                    "“That sounds amazing! What was your favorite part of the hike?”",
                    "“Yeah, whatever. I’m not really interested.”",
                    "“I’m bored, can we change the subject?”",
                    "“I don’t see why people get so excited about hiking.”"
                ],
                correctAnswer: "“That sounds amazing! What was your favorite part of the hike?”",
                mainSkill: "Active Listening"
            ),
            QuizQuestion(
                question: "What’s a good way to deepen the connection after laughing together?",
                answers: [
                    "“That was hilarious! We should swap more stories sometime.”",
                    "“I’m glad you messed up, that makes you less annoying.”",
                    "“I don’t have time to listen to silly stories.”",
                    "“You’re always so clumsy, aren’t you?”"
                ],
                correctAnswer: "“That was hilarious! We should swap more stories sometime.”",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "How do you casually suggest a get-together?",
                answers: [
                    "“If you’re interested, maybe we could grab coffee sometime?”",
                    "“You have to hang out with me this weekend, no excuses.”",
                    "“I guess you probably don’t want to spend time with me.”",
                    "“You better come to my place or I won’t talk to you again.”"
                ],
                correctAnswer: "“If you’re interested, maybe we could grab coffee sometime?”",
                mainSkill: "Confidence in Conversation"
            ),
            QuizQuestion(
                question: "What’s the best response when Alex seems unsure?",
                answers: [
                    "“No worries, maybe another time when it’s better for you.”",
                    "“You’re just making excuses to avoid me.”",
                    "“If you don’t want to hang out, just say so.”",
                    "“Fine, I guess you don’t care about this friendship.”"
                ],
                correctAnswer: "“No worries, maybe another time when it’s better for you.”",
                mainSkill: "Empathy and Tone"
            ),
            QuizQuestion(
                question: "What’s a good way to wrap up the chat?",
                answers: [
                    "“It was really nice talking to you, have a great day!”",
                    "“I’m glad this is over; see you around.”",
                    "“Well, don’t forget to call me next time you want to hang out.”",
                    "“I’m bored, I’m leaving now.”"
                ],
                correctAnswer: "“It was really nice talking to you, have a great day!”",
                mainSkill: "Professional Communication"
            ),
            QuizQuestion(
                question: "What’s a casual way to ask to stay in touch?",
                answers: [
                    "“Would you like to exchange numbers or maybe chat online sometime?”",
                    "“Give me your number or I won’t talk to you again.”",
                    "“I’m too busy to keep this up, but you can try reaching me.”",
                    "“Don’t bother contacting me if you’re not serious.”"
                ],
                correctAnswer: "“Would you like to exchange numbers or maybe chat online sometime?”",
                mainSkill: "Confidence in Conversation"
            )
        ],
        
        "Dealing with Awkward Moments": [
            QuizQuestion(
                question: "Someone accidentally spills coffee on you. What’s the best way to respond?",
                answers: [
                    "“It’s okay, accidents happen. Are you alright?”",
                    "“Watch where you’re going! That was careless.”",
                    "“Why are you so clumsy? You ruined my day.”",
                    "“I can’t believe you did that; now everything’s ruined.”"
                ],
                correctAnswer: "“It’s okay, accidents happen. Are you alright?”",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "You realize you called someone by the wrong name. How do you handle it?",
                answers: [
                    "“Sorry, I mixed up your name. Can you remind me again?”",
                    "“Oops, I forgot your name. Whatever.”",
                    "“I don’t care about your name anyway.”",
                    "“That’s not your real name, right?”"
                ],
                correctAnswer: "“Sorry, I mixed up your name. Can you remind me again?”",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "You accidentally interrupt someone mid-sentence. What’s the best response?",
                answers: [
                    "“Sorry for interrupting, please continue.”",
                    "“I just said something more important.”",
                    "“I wasn’t really listening, so it’s fine.”",
                    "“You’re too slow, I had to cut in.”"
                ],
                correctAnswer: "“Sorry for interrupting, please continue.”",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "You don’t know what to say during an awkward silence. What can help?",
                answers: [
                    "“I’m a bit nervous, but I’m glad to meet you.”",
                    "“This is so boring; I want to leave.”",
                    "“Why are you so quiet? Say something.”",
                    "“I don’t like this, let’s end it.”"
                ],
                correctAnswer: "“I’m a bit nervous, but I’m glad to meet you.”",
                mainSkill: "Handling Awkward Moments"
            ),
            QuizQuestion(
                question: "Someone shares something personal unexpectedly. How do you respond?",
                answers: [
                    "“Thank you for sharing that with me.”",
                    "“Why are you telling me this?”",
                    "“That’s not really my problem.”",
                    "“I don’t want to hear about your issues.”"
                ],
                correctAnswer: "“Thank you for sharing that with me.”",
                mainSkill: "Empathy and Tone"
            )
        ]
    ]
}
