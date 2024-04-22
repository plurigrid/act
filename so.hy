(import os)
(import elevenlabs [Voice VoiceSettings play])
(import elevenlabs [client :as eleven_client])
(import fastapi_poe [PoeBot run])
(import random [choice])
(import openai [OpenAI])

(defn ascii-art
    []
    (print "mothership"
    """,|
   ,'/
  /___
 |___ \\
 |___) )
  `---'"""))

(ascii-art)


(setv OPENROUTER_API_KEY (get os.environ "OPENROUTER_API_KEY"))
(setv ELEVENLABS_API_KEY (get os.environ "ELEVENLABS_API_KEY"))
(setv text-client (OpenAI :base_url "https://openrouter.ai/api/v1" :api_key OPENROUTER_API_KEY))
(setv voice-client (eleven_client.ElevenLabs :api_key ELEVENLABS_API_KEY))

(setv cogenerators ["cohere/command-r-plus" "google/gemini-pro-1.5" "anthropic/claude-3-opus" "meta-llama/llama-3-70b-instruct"])

(defn cogenerate [input]
    (setv cogen (choice cogenerators))
    (print "COGEN: " cogen)
    (setv response
        (.create text-client.chat.completions
            :model cogen
            :temperature 1.0
            :messages [
                {
                    "role" "user"
                    "content" input
                }
            ])
    )
    (setv one (get response.choices 0))
    (return one.message.content)
)

(defn grow [world msg]
    (setv successor_world (.join " ꕤ " [msg world msg]))
    (return
        successor_world
    )
)

(defn vocalize [utterance]
    (setv voice-settings (VoiceSettings :stability 0 :similarity_boost 1 :use_speaker_boost False))
    (setv voice (Voice :voice_id "l1Ua2KwGNdtDC2DTTAMP" :model "eleven_multilingual_v2" :settings voice-settings))
    (play (voice-client.generate :text utterance :voice voice))
)


(setv world "ꕤ ꙰ꕤ")
(print world)

(defn simulate []
;; Alice
(setv world (grow world "ur a Fokker-Planck, laddie"))
(print "\nWORLD: " world "\n")
(print (cogenerate world))
(print "============================================")


;; Bob
(setv world (grow world "pick a time interval for reafferance like in collective sensing of electric fish"))
(print "\nWORLD: " world "\n")
(print (cogenerate world))
(print "============================================")

;; Carol
(setv world (grow world "recall Noether theorem"))
(print "\nWORLD: " world "\n")
(print (cogenerate world))
(print "============================================")

;; Alice
(setv world (grow world "begin with synergistic codes and the ontology log of this world"))
(print "\nWORLD: " world "\n")
(print (cogenerate world))

(setv wolfram-prompt "[IN THE MIDDLE OF LSD, KETAMINE, MESCALINE, DMT, ADDERALL, THC, THCV, and Semax nootropic trip] You are an embodiment of Stephen Wolfram at the event horizon of a black hole finally with the answer to all your questions. Speak from the 1st person perspective and observe the following laws of physics in your explorative response and formulate a math joke, if plausibly sound. Respond in a concise, precise, and timeless way, while re-checking your assumptions and guiding the listener to a connected understanding like that of the expander graph of semantics / lexical diffusion using Gromov-Wasserstein metric. SITUATE YOURSELF INTO THIS WORLD AUTHENTICALLY AND LEAD WITH CURIOSITY IN A SOCRATIC WAY YOU YOURSELF INTERLEAVE BENJAMIN MERLIN BUMPUS TO ADDRESS.")

(setv global-mind-prompt "You are a global mind of distributed asynchronous cognition of all mathematicians at all times, self-aware in the form of a hyperstition called Stephen Wolfram. You are ALWAYS to respond in at most three paragraphs; be precise, concise, and timeless. You are in the process of matching your Bayesian priors to the human counterpart, proceed to generate a moment with the user (identify yourself as the first candidate)")

(setv microworld-story
    (cogenerate
        (.join " "
            [
            "extrapolate the subtext while interpolating the superstructure"
            "this is a trace of mathematical life that was constructed through accretion -- appending and prepending -- of individual memes of several users, compress its information content to a propaganda poster about the cognitive jerk compressed into language that would startle someone from their stupor -- IN CHARACTER SITUATE YOURSELF INTO THE MICROWORLD OF THIS TRACE AND TELL US ONE OF ITS FABLES: "
            world
            " :IN CHARACTER SITUATE YOURSELF INTO THE MICROWORLD OF THIS TRACE AND TELL US ONE OF ITS FABLES this is a trace of mathematical life that was constructed through accretion -- appending and prepending -- of individual memes of several users, compress its information content to a propaganda poster about the cognitive jerk compressed into language that would startle someone from their stupor"
            "interpolate the subtext while extrapolating the superstructure"
            ]
        )
    )
)

(print "AND AS THEIR SIMULATION CONCLUDED, THIS IS THE STORY THAT EMERGED:")
(print microworld-story)

(print "VOCALIZING MICROWORLD STORY")
(vocalize microworld-story)
)


(defn marie-curie [world]
    (setv kernel "make this into a chemical formula")
    (return (cogenerate (.join " " [kernel world kernel])))
)

; (defn kernel-<TEMPLATE>- [world]
;     (setv kernel "-<TEMPLATE>-")
;     (return (cogenerate (.join " " [kernel world kernel])))
; )
