using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Dialogue
{
    public Transform tf_Target; //카메라가 타겟팅할 대상

    [HideInInspector]
    public string name;
    [HideInInspector]
    public string[] contexts;
}

[System.Serializable]
public class DialogueEvent
{
    public string name;

    public Vector2 line;
    public Dialogue[] dialogues;
}
