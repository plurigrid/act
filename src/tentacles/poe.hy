(import os)
(import typing [AsyncIterable])
(import fastapi_poe [PoeBot PartialResponse run])
(import so [grow cogenerate])

(print (grow "oy" "vey"))
(setv POE_BOT_KEY (os.getenv "POE_BOT_KEY"))

(defclass ReflectBot [PoeBot]
    (defn __init__ [self world]
        (.__init__ (super))
        (setv self.world world)
    )

    (defn/a get_response [self query]
        (setv tabernacle (get query.query -1))
        (setv last_message tabernacle.content)
        (setv self.world (grow self.world last_message))
        (setv olam self.world)
        (setv foliation (.join " " ["**COGEN**\n\n" (cogenerate self.world)
                                "\n\n**WORLD**\n\n```\n" self.world "\n\n```"]))
        (yield (PartialResponse :text foliation))
    )
)

(run (ReflectBot "<-- I am the beginning and the end -- around me are the memes accrued by those who interact -- succesor haiku -- context distilled in geometric form inductive bias resonating worlds -->"))
