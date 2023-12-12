# AWS Polly

- A text-to-speech service
- Uses advanced deep learning technologies to synthesize speech that sounds like a human voice
- It supports saving text into MP3, OGG, and PCM file formats
- Offers Standard and Neutral TSS (NTTS) voices


## Concepts

- Speech Synthesis Markup Language (SSML)
    - Uses XML-based tags to modify different aspects of the text-to-speech output
    - Can be used to control the pronunciation, intonation, timing, and emotion of the speech output

- Standard TSS
    - Concatenates short speech snippets together
    - Limited in terms of producing different speaking styles

- Neural TTS (NTTS)
    - Produces higher quality speech output than Standard TTS
    - Neural TTS voices support two speaking styles:
        - Conversational
        - Newscaster

- Speech Mark
    - Provides detailed timing information about the individual phonemes and words of the synthesized speech
    - Can be used to highlight the words as they are spoken


## Features

- Pronouces out abbreviations and acronyms as they are spelled
- Homograph disambiguation
    - For example, "St." can be read as "street" or "saint".  Polly can disambiguate this based on the context of the sentence
- Custom lexicon
    - Supports customizing the pronunciation of words uncommon to the selected language

    
## References

https://tutorialsdojo.com/amazon-polly/
